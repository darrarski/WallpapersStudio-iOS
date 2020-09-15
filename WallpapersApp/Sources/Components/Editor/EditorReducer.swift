import Combine
import ComposableArchitecture
import CoreGraphics

typealias EditorReducer = Reducer<EditorState, EditorAction, EditorEnvironment>

let editorReducer = EditorReducer.combine(
  canvasReducer.optional().pullback(
    state: \.canvas,
    action: /EditorAction.canvas,
    environment: { _ in () }
  ),
  menuReducer.pullback(
    state: \.menu,
    action: /EditorAction.menu,
    environment: { _ in () }
  ),
  EditorReducer { state, action, env in
    switch action {
    case .presentImagePicker(let present):
      state.isPresentingImagePicker = present
      return .none

    case .toggleMenu:
      state.isPresentingMenu.toggle()
      return .none

    case .loadImage(let image):
      state.image = image
      state.canvas = CanvasState(
        size: state.canvas?.size ?? .zero,
        image: image,
        frame: CGRect(origin: .zero, size: image.size)
      )
      state.menu = MenuState(isImageLoaded: true)
      return .init(value: .canvas(.scaleToFill))

    case .exportImage:
      guard let canvas = state.canvas else { return .none }
      let image = env.renderCanvas(canvas)
      return env.savePhoto(image)
        .map { _ in EditorAction.didExportImage }
        .replaceError(with: EditorAction.didFailExportingImage)
        .eraseToEffect()

    case .didExportImage:
      state.isPresentingAlert = .exportSuccess
      return .none

    case .didFailExportingImage:
      state.isPresentingAlert = .exportFailure
      return .none

    case .dismissAlert:
      state.isPresentingAlert = nil
      return .none

    case .applyFilters:
      guard let image = state.image else { return .none }
      struct EffectID: Hashable {}
      return Deferred { [state] in
        Future { fulfill in
          var outputImage = image
          let blurRadius = state.menu.blur * 32
          if blurRadius > 0, let blurredImage = env.blurImage(outputImage, blurRadius) {
            outputImage = blurredImage
          }
          fulfill(.success(.didApplyFilters(outputImage)))
        }
      }
      .subscribe(on: env.filterQueue)
      .receive(on: env.mainQueue)
      .eraseToEffect()
      .cancellable(id: EffectID(), cancelInFlight: true)

    case .didApplyFilters(let image):
      state.canvas?.image = image
      return .none

    case .canvas(_):
      return .none

    case .menu(.importFromLibrary):
      return .init(value: .presentImagePicker(true))

    case .menu(.exportToLibrary):
      return .init(value: .exportImage)

    case .menu(.updateBlur(_)):
      return .init(value: .applyFilters)
    }
  }
)

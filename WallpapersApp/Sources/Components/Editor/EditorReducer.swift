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

    case .canvas(_):
      return .none

    case .menu(.importFromLibrary):
      return .init(value: .presentImagePicker(true))

    case .menu(.exportToLibrary):
      return .init(value: .exportImage)

    case .menu(.updateBlur(_)):
      if let image = state.image, let bluredImage = env.blurImage(image, state.menu.blur * 32) {
        state.canvas?.image = bluredImage
      }
      return .none
    }
  }
)

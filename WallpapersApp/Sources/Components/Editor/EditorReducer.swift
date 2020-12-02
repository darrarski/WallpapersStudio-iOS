import Combine
import ComposableArchitecture
import CoreGraphics

typealias EditorReducer = Reducer<EditorState, EditorAction, MainEnvironment>

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
      let isPresentingMenu = state.isPresentingMenu
      return .fireAndForget {
        env.appTelemetry.send(.toggleMenu(isPresentingMenu))
      }

    case .loadImage(let image):
      state.canvas = CanvasState(
        size: state.canvas?.size ?? .zero,
        image: image,
        frame: CGRect(origin: .zero, size: image.size)
      )
      return .merge(
        .init(value: .canvas(.scaleToFill)),
        .fireAndForget {
          env.appTelemetry.send(.loadImage(
            size: image.size,
            scale: image.scale
          ))
        }
      )

    case .exportImage:
      guard let canvas = state.canvas else { return .none }
      return Effect.future { fulfill in
        let image = env.renderCanvas(canvas)
        env.photoLibraryWriter.write(image: image) { error in
          if error == nil {
            fulfill(.success(.didExportImage))
          } else {
            fulfill(.success(.didFailExportingImage))
          }
        }
      }

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
      return .merge(
        .init(value: .presentImagePicker(true)),
        .fireAndForget {
          env.appTelemetry.send(.importFromLibrary)
        }
      )

    case .menu(.exportToLibrary):
      return .merge(
        .init(value: .exportImage),
        .fireAndForget {
          env.appTelemetry.send(.exportToLibrary)
        }
      )

    case .menu(_):
      return .none
    }
  }
)

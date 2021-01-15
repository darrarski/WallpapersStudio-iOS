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
        env.analytics.send(.toggleMenu(isPresentingMenu))
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
          env.analytics.send(.loadImage(
            size: image.size,
            scale: image.scale
          ))
        }
      )

    case .exportImage:
      guard let canvas = state.canvas else { return .none }
      return .merge(
        .future { fulfill in
          let image = env.renderCanvas(canvas)
          env.photoLibraryWriter.write(image: image) { error in
            if error == nil {
              fulfill(.success(.didExportImage))
            } else {
              fulfill(.success(.didFailExportingImage))
            }
          }
        },
        .fireAndForget {
          env.analytics.send(.exportImage(
            size: canvas.size,
            frame: canvas.frame,
            blur: canvas.blur,
            saturation: canvas.saturation,
            hue: canvas.hue
          ))
        }
      )

    case .didExportImage:
      state.isPresentingAlert = .exportSuccess
      return .fireAndForget {
        env.analytics.send(.didExportImage)
      }

    case .didFailExportingImage:
      state.isPresentingAlert = .exportFailure
      return .fireAndForget {
        env.analytics.send(.didFailExportingImage)
      }

    case .dismissAlert:
      state.isPresentingAlert = nil
      return .none

    case .canvas(_):
      return .none

    case .menu(.importFromLibrary):
      return .merge(
        .init(value: .presentImagePicker(true)),
        .fireAndForget {
          env.analytics.send(.importFromLibrary)
        }
      )

    case .menu(.exportToLibrary):
      return .merge(
        .init(value: .exportImage),
        .fireAndForget {
          env.analytics.send(.exportToLibrary)
        }
      )

    case .menu(_):
      return .none
    }
  }
)

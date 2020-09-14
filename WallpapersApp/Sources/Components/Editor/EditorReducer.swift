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
      state.canvas = CanvasState(
        size: state.canvas?.size ?? .zero,
        image: image,
        frame: CGRect(origin: .zero, size: image.size)
      )
      state.menu.isImageLoaded = true
      return .init(value: .canvas(.scaleToFill))

    case .exportImage:
      guard let canvas = state.canvas else { return .none }
      let image = env.renderCanvas(canvas)
      // TODO: save to photo library
      // UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
      return .merge(
        .init(value: .loadImage(image)),
        .init(value: .canvas(.scaleToFill))
      )

    case .canvas(_):
      return .none

    case .menu(.importFromLibrary):
      return .init(value: .presentImagePicker(true))

    case .menu(.exportToLibrary):
      return .init(value: .exportImage)
    }
  }
)

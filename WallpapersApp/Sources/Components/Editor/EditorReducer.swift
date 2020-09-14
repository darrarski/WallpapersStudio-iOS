import ComposableArchitecture
import CoreGraphics
import class UIKit.UIGraphicsImageRenderer

typealias EditorReducer = Reducer<EditorState, EditorAction, Void>

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
  EditorReducer { state, action, _ in
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
      let renderingBounds = CGRect(origin: .zero, size: canvas.size)
      let renderer = UIGraphicsImageRenderer(bounds: renderingBounds)
      let exportedImage = renderer.image { _ in
        canvas.image.draw(in: canvas.frame)
      }
      // TODO: save to photo library
      // UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
      // return .none
      return .merge(
        .init(value: .loadImage(exportedImage)),
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
).debug()

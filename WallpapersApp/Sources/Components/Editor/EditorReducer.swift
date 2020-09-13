import ComposableArchitecture
import struct CoreGraphics.CGRect
import struct CoreGraphics.CGPoint
import class UIKit.UIGraphicsImageRenderer

typealias EditorReducer = Reducer<EditorState, EditorAction, EditorEnvironment>

let editorReducer = EditorReducer { state, action, env in
  switch action {
  case .presentImagePicker(let present):
    state.isPresentingImagePicker = present
    return .none

  case .toggleConfig:
    state.isPresentingConfig.toggle()
    return .none

  case .loadImage(let image, let viewSize):
    state.image = image
    state.imageFrame = CGRect(
      origin: CGPoint(
        x: (image.size.width - viewSize.width) / -2,
        y: (image.size.height - viewSize.height) / -2
      ),
      size: image.size
    )
    state.imageFrame = state.imageFrame
      .applying(.scaledBy(
        max(viewSize.width / image.size.width, viewSize.height / image.size.height),
        anchor: state.imageFrame.center
      ))
    state.imageFrame = state.imageFrame
      .applying(.scaledBy(1.1, anchor: state.imageFrame.center))
    return .none

  case .updateImageOffset(let delta):
    state.imageFrame = state.imageFrame.applying(
      .init(translationX: delta.x, y: delta.y)
    )
    return .none

  case .updateImageScale(let delta, let viewSize):
    state.imageFrame = state.imageFrame.applying(
      .scaledBy(delta, anchor: CGPoint(
        x: viewSize.width / 2,
        y: viewSize.height / 2
      ))
    )
    return .none

  case .exportImage(let size):
    guard let image = state.image else { return .none }
    var renderingBounds = CGRect(origin: .zero, size: size)
    renderingBounds = renderingBounds.applying(.scaledBy(1.1, anchor: renderingBounds.center))
    let renderer = UIGraphicsImageRenderer(bounds: renderingBounds)
    let exportedImage = renderer.image { _ in
      image.draw(in: state.imageFrame)
    }
    // TODO: save to photo library
    // UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    // return .none
    return .init(value: .loadImage(exportedImage, viewSize: size))
  }
}.debug()

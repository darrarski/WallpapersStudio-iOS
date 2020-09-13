import class UIKit.UIImage
import struct CoreGraphics.CGRect

struct EditorViewState: Equatable {
  let image: UIImage?
  let imageFrame: CGRect
  let isPresentingImagePicker: Bool
  let isPresentingConfig: Bool

  init(state: EditorState) {
    image = state.image
    imageFrame = state.imageFrame
    isPresentingImagePicker = state.isPresentingImagePicker
    isPresentingConfig = state.isPresentingConfig
  }
}

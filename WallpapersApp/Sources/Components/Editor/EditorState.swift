import class UIKit.UIImage
import struct CoreGraphics.CGRect

struct EditorState {
  var image: UIImage? = nil
  var imageFrame: CGRect = .zero
  var isPresentingImagePicker = false
  var isPresentingConfig = true
}

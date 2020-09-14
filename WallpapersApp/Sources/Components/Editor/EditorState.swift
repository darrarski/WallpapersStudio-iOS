import class UIKit.UIImage
import struct CoreGraphics.CGRect

struct EditorState {
  var canvas: CanvasState?
  var isPresentingImagePicker = false
  var isPresentingConfig = true
}

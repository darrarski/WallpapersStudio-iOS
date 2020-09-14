import class UIKit.UIImage
import struct CoreGraphics.CGRect

struct EditorState {
  var canvas: CanvasState?
  var menu = MenuState()
  var isPresentingImagePicker = false
  var isPresentingMenu = true
}

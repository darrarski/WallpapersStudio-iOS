import class UIKit.UIImage
import struct CoreGraphics.CGRect

struct EditorState: Equatable {
  var canvas: CanvasState?
  var menu = MenuState()
  var isPresentingImagePicker = false
  var isPresentingMenu = true
  var isPresentingAlert: Alert?
}

extension EditorState {
  enum Alert: Equatable {
    case exportSuccess
    case exportFailure
  }
}

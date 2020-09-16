import class UIKit.UIImage
import struct CoreGraphics.CGRect

struct EditorState: Equatable {
  var image: UIImage?
  var canvas: CanvasState?
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

extension EditorState {
  var menu: MenuState {
    get { MenuState(isImageLoaded: image != nil, blur: canvas?.blur ?? 0) }
    set { canvas?.blur = newValue.blur }
  }
}

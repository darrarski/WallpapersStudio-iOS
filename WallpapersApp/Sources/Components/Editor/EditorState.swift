import class UIKit.UIImage
import struct CoreGraphics.CGRect

struct EditorState: Equatable {
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
    get {
      MenuState(
        isImageLoaded: canvas != nil,
        blur: canvas?.blur ?? 0,
        saturation: canvas?.saturation ?? 1,
        hue: canvas?.hue ?? 0
      )
    }
    set {
      canvas?.blur = newValue.blur
      canvas?.saturation = newValue.saturation
      canvas?.hue = newValue.hue
    }
  }
}

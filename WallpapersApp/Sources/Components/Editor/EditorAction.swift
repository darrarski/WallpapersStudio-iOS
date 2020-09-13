import CoreGraphics
import class UIKit.UIImage

enum EditorAction {
  case presentImagePicker(Bool)
  case toggleConfig
  case loadImage(UIImage, viewSize: CGSize)
  case updateImageOffset(delta: CGPoint)
  case updateImageScale(delta: CGFloat, viewSize: CGSize)
  case exportImage(size: CGSize)
}

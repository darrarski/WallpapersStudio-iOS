import CoreGraphics
import class UIKit.UIImage

struct CanvasState: Equatable {
  var size: CGSize
  var image: UIImage
  var frame: CGRect
  var blur: CGFloat = 0
  var saturation: CGFloat = 1
}

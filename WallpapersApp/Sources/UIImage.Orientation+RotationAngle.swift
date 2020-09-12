import UIKit

extension UIImage.Orientation {
  var rotationAngle: CGFloat {
    switch self {
    case .down, .downMirrored:
      return .pi

    case .left, .leftMirrored:
      return .pi / 2

    case .right, .rightMirrored:
      return .pi / -2

    case .up, .upMirrored:
      return 0

    @unknown default:
      return 0
    }
  }
}

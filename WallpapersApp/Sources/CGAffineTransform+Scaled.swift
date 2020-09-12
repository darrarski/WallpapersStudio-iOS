import SwiftUI

extension CGAffineTransform {
  static func scaledBy(_ scale: CGFloat) -> CGAffineTransform {
    CGAffineTransform.identity.scaledBy(scale)
  }

  func scaledBy(_ scale: CGFloat) -> CGAffineTransform {
    scaledBy(x: scale, y: scale)
  }
}

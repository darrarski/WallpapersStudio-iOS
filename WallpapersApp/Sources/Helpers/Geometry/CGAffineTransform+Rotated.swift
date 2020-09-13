import CoreGraphics

extension CGAffineTransform {
  static func rotated(angle: CGFloat, anchor: CGPoint) -> CGAffineTransform {
    CGAffineTransform.identity.rotated(angle: angle, anchor: anchor)
  }

  func rotated(angle: CGFloat, anchor: CGPoint) -> CGAffineTransform {
    translatedBy(x: anchor.x, y: anchor.y)
      .rotated(by: angle)
      .translatedBy(x: -anchor.x, y: -anchor.y)
  }
}

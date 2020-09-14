import CoreGraphics

extension CGAffineTransform {
  static func scaledBy(_ scale: CGFloat, anchor: CGPoint = .zero) -> CGAffineTransform {
    CGAffineTransform.identity.scaledBy(scale, anchor: anchor)
  }

  func scaledBy(_ scale: CGFloat, anchor: CGPoint = .zero) -> CGAffineTransform {
    translatedBy(x: anchor.x, y: anchor.y)
      .scaledBy(x: scale, y: scale)
      .translatedBy(x: -anchor.x, y: -anchor.y)
  }
}

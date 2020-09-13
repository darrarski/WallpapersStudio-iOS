import CoreGraphics

extension CGAffineTransform {
  static func scaledBy(x: CGFloat, y: CGFloat, anchor: CGPoint = .zero) -> CGAffineTransform {
    CGAffineTransform.identity.scaledBy(x: x, y: y, anchor: anchor)
  }

  func scaledBy(x: CGFloat, y: CGFloat, anchor: CGPoint = .zero) -> CGAffineTransform {
    translatedBy(x: anchor.x, y: anchor.y)
      .scaledBy(x: x, y: y)
      .translatedBy(x: -anchor.x, y: -anchor.y)
  }

  static func scaledBy(_ scale: CGFloat, anchor: CGPoint = .zero) -> CGAffineTransform {
    CGAffineTransform.identity.scaledBy(scale, anchor: anchor)
  }

  func scaledBy(_ scale: CGFloat, anchor: CGPoint = .zero) -> CGAffineTransform {
    scaledBy(x: scale, y: scale, anchor: anchor)
  }
}

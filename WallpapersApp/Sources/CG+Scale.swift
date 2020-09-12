import SwiftUI

extension CGPoint {
  func scaled(by scale: CGFloat) -> CGPoint {
    applying(.init(scaleX: scale, y: scale))
  }
}

extension CGSize {
  func scaled(by scale: CGFloat) -> CGSize {
    applying(.init(scaleX: scale, y: scale))
  }
}

extension CGRect {
  func scaled(by scale: CGFloat) -> CGRect {
    applying(.init(scaleX: scale, y: scale))
  }
}

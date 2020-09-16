import SwiftUI

struct RoundedRect: Shape {
  var corners: UIRectCorner
  var radius: CGSize

  init(corners: UIRectCorner, radius: CGSize) {
    self.corners = corners
    self.radius = radius
  }

  init(corners: UIRectCorner, radius: CGFloat) {
    self.corners = corners
    self.radius = CGSize(width: radius, height: radius)
  }

  func path(in rect: CGRect) -> Path {
    Path(UIBezierPath(
      roundedRect: rect,
      byRoundingCorners: corners,
      cornerRadii: radius
    ).cgPath)
  }
}

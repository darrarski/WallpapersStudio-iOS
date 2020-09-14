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

#if DEBUG
struct RoundedRect_Previews: PreviewProvider {
  static var previews: some View {
    RoundedRect(
      corners: .allCorners,
      radius: CGSize(width: 16, height: 16)
    )
    .fill(Color.blue)
    .padding(8)
    .background(Color.white)
    .previewLayout(.fixed(width: 128, height: 128))
  }
}
#endif

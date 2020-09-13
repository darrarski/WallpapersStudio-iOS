import SwiftUI

extension GeometryProxy {
  var sizeIgnoringSafeArea: CGSize {
    CGSize(
      width: size.width + safeAreaInsets.leading + safeAreaInsets.trailing,
      height: size.height + safeAreaInsets.top + safeAreaInsets.bottom
    )
  }
}

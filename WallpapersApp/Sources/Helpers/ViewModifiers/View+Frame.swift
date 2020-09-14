import SwiftUI

extension View {
  func frame(size: CGSize, alignment: Alignment = .center) -> some View {
    frame(width: size.width, height: size.height, alignment: alignment)
  }
}

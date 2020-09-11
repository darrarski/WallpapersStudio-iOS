import SwiftUI

struct MagnificationModifier: ViewModifier {
  @Binding var scale: CGFloat
  @State private var lastScale: CGFloat = 1

  func body(content: Content) -> some View {
    content.simultaneousGesture(
      MagnificationGesture()
        .onChanged { value in
          let delta = value / self.lastScale
          self.lastScale = value
          self.scale *= delta
        }
        .onEnded { value in
          self.lastScale = 1
        },
      including: .all
    )
  }
}

extension View {
  func onMagnify(updateScale scale: Binding<CGFloat>) -> some View {
    modifier(MagnificationModifier(scale: scale))
  }
}

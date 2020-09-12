import SwiftUI

struct MagnificationModifier: ViewModifier {
  var onChange: (CGFloat) -> Void
  @State private var lastScale: CGFloat = 1

  func body(content: Content) -> some View {
    content.simultaneousGesture(
      MagnificationGesture()
        .onChanged { value in
          let delta = value / self.lastScale
          self.lastScale = value
          self.onChange(delta)
        }
        .onEnded { value in
          self.lastScale = 1
        },
      including: .all
    )
  }
}

extension View {
  func onMagnify(updateScale onChange: @escaping (CGFloat) -> Void) -> some View {
    modifier(MagnificationModifier(onChange: onChange))
  }
}

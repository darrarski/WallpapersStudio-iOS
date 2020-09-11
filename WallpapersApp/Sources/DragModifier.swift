import SwiftUI

struct DragModifier: ViewModifier {
  @Binding var offset: CGPoint
  @State private var lastOffset: CGPoint = .zero

  func body(content: Content) -> some View {
    content.simultaneousGesture(
      DragGesture()
        .onChanged { value in
          let offset = CGPoint(
            x: value.location.x - value.startLocation.x,
            y: value.location.y - value.startLocation.y
          )
          let delta = CGPoint(
            x: offset.x - self.lastOffset.x,
            y: offset.y - self.lastOffset.y
          )
          self.lastOffset = offset
          self.offset.x += delta.x
          self.offset.y += delta.y
        }
        .onEnded { value in
          self.lastOffset = .zero
        },
      including: .all
    )
  }
}

extension View {
  func onDrag(updateOffset offset: Binding<CGPoint>) -> some View {
    modifier(DragModifier(offset: offset))
  }
}

import SwiftUI

struct DragModifier: ViewModifier {
  var onChange: (CGPoint) -> Void
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
          self.onChange(delta)
        }
        .onEnded { value in
          self.lastOffset = .zero
        },
      including: .all
    )
  }
}

extension View {
  func onDrag(updateOffset onChange: @escaping (CGPoint) -> Void) -> some View {
    modifier(DragModifier(onChange: onChange))
  }
}

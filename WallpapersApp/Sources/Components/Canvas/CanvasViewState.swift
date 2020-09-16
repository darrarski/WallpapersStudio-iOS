import CoreGraphics
import class UIKit.UIImage

struct CanvasViewState: Equatable {
  let image: UIImage
  let imageFrame: CGRect
  let blurRadius: CGFloat

  init(state: CanvasState) {
    self.image = state.image
    self.imageFrame = CGRect(
      origin: CGPoint(
        x: (state.frame.width - state.size.width) / 2 + state.frame.minX,
        y: (state.frame.height - state.size.height) / 2 + state.frame.minY
      ),
      size: state.frame.size
    )
    self.blurRadius = state.blur * max(state.image.size.width, state.image.size.height) / 100
  }
}

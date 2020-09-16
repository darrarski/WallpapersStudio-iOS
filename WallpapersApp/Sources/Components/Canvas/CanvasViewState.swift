import CoreGraphics
import class UIKit.UIImage
import struct SwiftUI.Angle

struct CanvasViewState: Equatable {
  let image: UIImage
  let imageFrame: CGRect
  let blurRadius: CGFloat
  let saturationAmount: Double
  let hueRotation: Angle

  init(state: CanvasState) {
    self.image = state.image
    self.imageFrame = CGRect(
      origin: CGPoint(
        x: (state.frame.width - state.size.width) / 2 + state.frame.minX,
        y: (state.frame.height - state.size.height) / 2 + state.frame.minY
      ),
      size: state.frame.size
    )
    self.blurRadius = state.blur * state.size.width / 10
    self.saturationAmount = Double(state.saturation)
    self.hueRotation = Angle(degrees: Double(state.hue))
  }
}

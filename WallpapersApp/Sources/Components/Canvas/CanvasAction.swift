import CoreGraphics

enum CanvasAction: Equatable {
  case updateSize(CGSize)
  case updateOffset(delta: CGPoint)
  case updateScale(delta: CGFloat)
  case scaleToFill
}

import CoreGraphics

enum CanvasAction {
  case updateSize(CGSize)
  case updateOffset(delta: CGPoint)
  case updateScale(delta: CGFloat)
  case scaleToFill
}

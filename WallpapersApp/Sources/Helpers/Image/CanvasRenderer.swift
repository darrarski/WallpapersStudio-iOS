import CoreGraphics
import class UIKit.UIImage
import class UIKit.UIGraphicsImageRenderer

typealias CanvasRenderer = (CanvasState) -> UIImage

let defaultCanvasRenderer: CanvasRenderer = { canvas in
  UIGraphicsImageRenderer(size: canvas.size).image { _ in
    canvas.image.draw(in: canvas.frame)
  }
}

import ComposableArchitecture
import SwiftUI
import UIKit

typealias CanvasRenderer = (CanvasState) -> UIImage

let defaultCanvasRenderer: CanvasRenderer = { canvas in
  let canvasView = CanvasView(store: Store(
    initialState: canvas,
    reducer: .empty,
    environment: ()
  ))
  let viewController = UIHostingController(rootView: canvasView)
  let view = viewController.view!
  view.frame = CGRect(origin: .zero, size: canvas.size)
  return UIGraphicsImageRenderer(size: view.bounds.size).image { context in
    view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
  }
}

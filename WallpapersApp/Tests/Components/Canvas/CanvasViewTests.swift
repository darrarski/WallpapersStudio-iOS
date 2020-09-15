import XCTest
import SnapshotTesting
@testable import WallpapersApp
import ComposableArchitecture
import SwiftUI

final class CanvasViewTests: XCTestCase {
  func testSnapshotWithImage() {
    assertSnapshot(
      matching: CanvasView(store: Store(
        initialState: CanvasState(
          size: CGSize(width: 100, height: 100),
          image: image(color: .red, size: CGSize(width: 20, height: 20)),
          frame: CGRect(
            origin: CGPoint(x: 15, y: 15),
            size: CGSize(width: 20, height: 20)
          )
        ),
        reducer: .empty,
        environment: ()
      )),
      as: .image(
        drawHierarchyInKeyWindow: true,
        precision: 0.99,
        layout: .fixed(width: 100, height: 100),
        traits: .init(userInterfaceStyle: .light)
      )
    )
  }

  private func image(color: UIColor, size: CGSize) -> UIImage {
    UIGraphicsImageRenderer(size: size).image { context in
      color.setFill()
      context.fill(CGRect(origin: .zero, size: size))
    }
  }
}

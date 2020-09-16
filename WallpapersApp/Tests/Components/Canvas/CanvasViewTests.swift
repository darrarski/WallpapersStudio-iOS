import XCTest
import SnapshotTesting
@testable import WallpapersApp
import ComposableArchitecture
import SwiftUI

final class CanvasViewTests: XCTestCase {
  func testSnapshotWithImage() {
    let state = CanvasState(
      size: CGSize(width: 500, height: 500),
      image: image(size: CGSize(width: 80, height: 80)),
      frame: CGRect(
        origin: CGPoint(x: 75, y: 75),
        size: CGSize(width: 80, height: 80)
      )
    )

    assertSnapshot(
      matching: CanvasView(store: Store(
        initialState: state,
        reducer: .empty,
        environment: ()
      )),
      as: .image(
        drawHierarchyInKeyWindow: true,
        precision: 0.99,
        layout: .fixed(width: state.size.width, height: state.size.height),
        traits: .init(userInterfaceStyle: .light)
      )
    )
  }

  func testSnaphotWithBlurredImage() {
    let state = CanvasState(
      size: CGSize(width: 500, height: 500),
      image: image(size: CGSize(width: 80, height: 80)),
      frame: CGRect(
        origin: CGPoint(x: 75, y: 75),
        size: CGSize(width: 80, height: 80)
      ),
      blur: 0.1
    )

    assertSnapshot(
      matching: CanvasView(store: Store(
        initialState: state,
        reducer: .empty,
        environment: ()
      )),
      as: .image(
        drawHierarchyInKeyWindow: true,
        precision: 0.99,
        layout: .fixed(width: state.size.width, height: state.size.height),
        traits: .init(userInterfaceStyle: .light)
      )
    )
  }

  func testSnaphotWithDesaturatedImage() {
    let state = CanvasState(
      size: CGSize(width: 500, height: 500),
      image: image(size: CGSize(width: 80, height: 80)),
      frame: CGRect(
        origin: CGPoint(x: 75, y: 75),
        size: CGSize(width: 80, height: 80)
      ),
      saturation: 0.2
    )

    assertSnapshot(
      matching: CanvasView(store: Store(
        initialState: state,
        reducer: .empty,
        environment: ()
      )),
      as: .image(
        drawHierarchyInKeyWindow: true,
        precision: 0.99,
        layout: .fixed(width: state.size.width, height: state.size.height),
        traits: .init(userInterfaceStyle: .light)
      )
    )
  }

  func testSnaphotWithRotatedHueOfImage() {
    let state = CanvasState(
      size: CGSize(width: 500, height: 500),
      image: image(size: CGSize(width: 80, height: 80)),
      frame: CGRect(
        origin: CGPoint(x: 75, y: 75),
        size: CGSize(width: 80, height: 80)
      ),
      hue: 180
    )

    assertSnapshot(
      matching: CanvasView(store: Store(
        initialState: state,
        reducer: .empty,
        environment: ()
      )),
      as: .image(
        drawHierarchyInKeyWindow: true,
        precision: 0.99,
        layout: .fixed(width: state.size.width, height: state.size.height),
        traits: .init(userInterfaceStyle: .light)
      )
    )
  }

  private func image(size: CGSize) -> UIImage {
    UIGraphicsImageRenderer(size: size).image { context in
      let halfSize = CGSize(width: size.width / 2, height: size.height / 2)
      let rectangles: [(color: UIColor, frame: CGRect)] = [
        (.red, CGRect(origin: .zero, size: halfSize)),
        (.green, CGRect(origin: CGPoint(x: size.width / 2, y: 0), size: halfSize)),
        (.blue, CGRect(origin: CGPoint(x: 0, y: size.height / 2), size: halfSize)),
        (.yellow, CGRect(origin: CGPoint(x: size.width / 2, y: size.height / 2), size: halfSize)),
        (.black, CGRect(origin: CGPoint(x: size.width / 4, y: size.height / 4), size: halfSize))
      ]
      rectangles.forEach { rectangle in
        rectangle.color.setFill()
        context.fill(rectangle.frame)
      }
    }
  }
}

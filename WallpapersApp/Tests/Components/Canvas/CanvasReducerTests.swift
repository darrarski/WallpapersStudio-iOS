import XCTest
@testable import WallpapersApp
import ComposableArchitecture

final class CanvasReducerTests: XCTestCase {
  var store: TestStore<CanvasState, CanvasState, CanvasAction, CanvasAction, Void>!

  override func setUp() {
    store = TestStore(
      initialState: CanvasState(
        size: CGSize(width: 400, height: 600),
        image: image(size: CGSize(width: 1000, height: 800)),
        frame: CGRect(origin: .zero, size: CGSize(width: 1000, height: 800))
      ),
      reducer: canvasReducer,
      environment: ()
    )
  }

  override func tearDown() {
    store = nil
  }

  func testUpdateSize() {
    store.assert(
      .send(.updateSize(CGSize(width: 100, height: 100))) {
        $0.size = CGSize(width: 100, height: 100)
      },
      .send(.updateSize(.zero)) {
        $0.size = .zero
      },
      .send(.updateSize(CGSize(width: 400, height: 600))) {
        $0.size = CGSize(width: 400, height: 600)
      },
      .receive(.scaleToFill) {
        $0.frame = CGRect(
          origin: CGPoint(x: -195, y: -16),
          size: CGSize(width: 790, height: 632)
        )
      }
    )
  }

  func testUpdateOffset() {
    store.assert(
      .send(.updateOffset(delta: CGPoint(x: 1, y: 2))) {
        $0.frame.origin = CGPoint(x: 1, y: 2)
      }
    )
  }

  func testUpdateScale() {
    store.assert(
      .send(.updateScale(delta: 1.5)) {
        $0.frame = CGRect(
          origin: CGPoint(x: -100, y: -150),
          size: CGSize(width: 1500, height: 1200)
        )
      }
    )
  }

  func testScaleToFill() {
    store.assert(
      .send(.scaleToFill) {
        $0.frame = CGRect(
          origin: CGPoint(x: -195, y: -16),
          size: CGSize(width: 790, height: 632)
        )
      }
    )
  }

  private func image(size: CGSize) -> UIImage {
    UIGraphicsImageRenderer(size: size).image { context in
      UIColor.red.setFill()
      context.fill(CGRect(origin: .zero, size: size))
    }
  }
}

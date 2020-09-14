import XCTest
@testable import WallpapersApp
import ComposableArchitecture

final class CanvasReducerTests: XCTestCase {
  var store: TestStore<CanvasState, CanvasState, CanvasAction, CanvasAction, Void>!

  override func setUp() {
    store = TestStore(
      initialState: CanvasState(
        size: CGSize(width: 4, height: 6),
        image: image(size: CGSize(width: 10, height: 8)),
        frame: CGRect(origin: .zero, size: CGSize(width: 10, height: 8))
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
      .send(.updateSize(CGSize(width: 10, height: 10))) {
        $0.size = CGSize(width: 10, height: 10)
      },
      .send(.updateSize(.zero)) {
        $0.size = .zero
      },
      .send(.updateSize(CGSize(width: 4, height: 6))) {
        $0.size = CGSize(width: 4, height: 6)
      },
      .receive(.scaleToFill) {
        $0.frame = CGRect(
          origin: CGPoint(x: -1.75, y: 0),
          size: CGSize(width: 7.5, height: 6)
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
          origin: CGPoint(x: -1, y: -1.5),
          size: CGSize(width: 15, height: 12)
        )
      }
    )
  }

  func testScaleToFill() {
    store.assert(
      .send(.scaleToFill) {
        $0.frame = CGRect(
          origin: CGPoint(x: -1.75, y: 0),
          size: CGSize(width: 7.5, height: 6)
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

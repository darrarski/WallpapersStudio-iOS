import XCTest
@testable import WallpapersApp
import ComposableArchitecture

final class EditorReducerTests: XCTestCase {
  var store: TestStore<EditorState, EditorState, EditorAction, EditorAction, Void>!

  override func setUp() {
    store = TestStore(
      initialState: EditorState(),
      reducer: editorReducer,
      environment: ()
    )
  }

  override func tearDown() {
    store = nil
  }

  func testPresentImagePicker() {
    store.assert(
      .send(.presentImagePicker(true)) {
        $0.isPresentingImagePicker = true
      },
      .send(.presentImagePicker(false)) {
        $0.isPresentingImagePicker = false
      }
    )
  }

  func testToggleMenu() {
    store.assert(
      .send(.toggleMenu) {
        $0.isPresentingMenu.toggle()
      },
      .send(.toggleMenu) {
        $0.isPresentingMenu.toggle()
      }
    )
  }

  func testLoadImage() {
    let image1 = image(color: .red, size: CGSize(width: 6, height: 4))
    let image2 = image(color: .blue, size: CGSize(width: 3, height: 6))

    store.assert(
      .send(.loadImage(image1)) {
        $0.canvas = CanvasState(
          size: .zero,
          image: image1,
          frame: CGRect(origin: .zero, size: image1.size)
        )
        $0.menu.isImageLoaded = true
      },
      .receive(.canvas(.scaleToFill)) {
        $0.canvas?.frame.size = .zero
      },
      .send(.canvas(.updateSize(CGSize(width: 3, height: 4)))) {
        $0.canvas?.size = CGSize(width: 3, height: 4)
      },
      .receive(.canvas(.scaleToFill)) {
        $0.canvas?.frame.origin = CGPoint(x: -1.5, y: 0)
        $0.canvas?.frame.size = image1.size
      },
      .send(.loadImage(image2)) {
        $0.canvas?.image = image2
        $0.canvas?.frame.origin = .zero
        $0.canvas?.frame.size = image2.size
      },
      .receive(.canvas(.scaleToFill)) {
        $0.canvas?.frame.origin = CGPoint(x: 0, y: -1)
      }
    )
  }

  private func image(color: UIColor, size: CGSize) -> UIImage {
    UIGraphicsImageRenderer(size: size).image { context in
      color.setFill()
      context.fill(CGRect(origin: .zero, size: size))
    }
  }
}

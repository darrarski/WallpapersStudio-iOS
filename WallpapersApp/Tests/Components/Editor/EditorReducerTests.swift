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
        $0.isPresentingMenu = false
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
}

import XCTest
@testable import WallpapersApp
import ComposableArchitecture

final class MenuReducerTests: XCTestCase {
  var store: TestStore<MenuState, MenuState, MenuAction, MenuAction, Void>!

  override func setUp() {
    store = TestStore(
      initialState: MenuState(
        isImageLoaded: false,
        blur: 0
      ),
      reducer: menuReducer,
      environment: ()
    )
  }

  override func tearDown() {
    store = nil
  }

  func testImportFromLibrary() {
    store.assert(
      .send(.importFromLibrary)
    )
  }

  func testExportToLibrary() {
    store.assert(
      .send(.exportToLibrary)
    )
  }

  func testUpdateBlur() {
    store.assert(
      .send(.updateBlur(0.33)) {
        $0.blur = 0.33
      },
      .send(.updateBlur(0)) {
        $0.blur = 0
      },
      .send(.updateBlur(1)) {
        $0.blur = 1
      },
      .send(.updateBlur(-0.1)) {
        $0.blur = 0
      },
      .send(.updateBlur(1.1)) {
        $0.blur = 1
      }
    )
  }
}

import XCTest
@testable import WallpapersApp
import ComposableArchitecture

final class MenuReducerTests: XCTestCase {
  var store: TestStore<MenuState, MenuState, MenuAction, MenuAction, Void>!

  override func setUp() {
    store = TestStore(
      initialState: MenuState(),
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
}

import XCTest
@testable import WallpapersApp
import ComposableArchitecture

final class MainReducerTests: XCTestCase {
  var store: TestStore<MainState, MainState, MainAction, MainAction, MainEnvironment>!

  override func setUp() {
    store = TestStore(
      initialState: MainState(),
      reducer: mainReducer,
      environment: MainEnvironment(
        renderCanvas: { _ in fatalError() }
      )
    )
  }

  override func tearDown() {
    store = nil
  }

  func testEditorAction() {
    store.assert(
      .send(.editor(.toggleMenu)) {
        $0.editor.isPresentingMenu.toggle()
      }
    )
  }
}

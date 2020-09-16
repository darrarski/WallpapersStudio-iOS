import XCTest
@testable import WallpapersApp
import ComposableArchitecture

final class MenuReducerTests: XCTestCase {
  var store: TestStore<MenuState, MenuState, MenuAction, MenuAction, Void>!

  override func setUp() {
    store = TestStore(
      initialState: MenuState(
        isImageLoaded: false,
        blur: 0,
        saturation: 1,
        hue: 0
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

  func testUpdateFilters() {
    store.assert(
      .send(.updateBlur(0.33)) {
        $0.blur = 0.33
      },
      .send(.updateSaturation(1.5)) {
        $0.saturation = 1.5
      },
      .send(.updateHue(180)) {
        $0.hue = 180
      }
    )
  }
}

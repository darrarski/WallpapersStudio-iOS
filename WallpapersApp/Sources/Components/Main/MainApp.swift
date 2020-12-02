import SwiftUI
import ComposableArchitecture

@main
struct MainApp: App {
  let store: Store<MainState, MainAction>

  init() {
    let environment = MainEnvironment()
    store = Store(
      initialState: MainState(),
      reducer: mainReducer,
      environment: environment
    )
  }

  var body: some Scene {
    WindowGroup {
      if NSClassFromString("XCTestCase") == nil {
        EditorView(store: store.scope(
          state: \.editor,
          action: MainAction.editor
        ))
      }
    }
  }
}

import SwiftUI
import ComposableArchitecture
import TelemetryClient

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
    environment.analytics.setup()
    environment.analytics.send(.appStart)
  }

  var body: some Scene {
    WindowGroup {
      if !isRunningTests {
        EditorView(store: store.scope(
          state: \.editor,
          action: MainAction.editor
        ))
      }
    }
  }
}

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
    let appTelemetryConfig = TelemetryManagerConfiguration(
      appID: "YOUR-APP-UNIQUE-IDENTIFIER"
    )
    environment.appTelemetry.initialize(appTelemetryConfig)
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

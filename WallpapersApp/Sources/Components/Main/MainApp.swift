import SwiftUI
import ComposableArchitecture

@main
struct MainApp: App {
  var body: some Scene {
    WindowGroup {
      EditorView(store: Store(
        initialState: EditorState(),
        reducer: editorReducer,
        environment: EditorEnvironment()
      ))
    }
  }
}

import ComposableArchitecture

typealias MainReducer = Reducer<MainState, MainAction, MainEnvironment>

let mainReducer = MainReducer.combine(
  editorReducer.pullback(
    state: \.editor,
    action: /MainAction.editor,
    environment: { $0 }
  ),
  MainReducer { _, action, _ in
    switch action {
    case .editor(_):
      return .none
    }
  }
)

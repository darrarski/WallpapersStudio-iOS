import ComposableArchitecture

typealias MainReducer = Reducer<MainState, MainAction, Void>

let mainReducer = MainReducer.combine(
  editorReducer.pullback(
    state: \.editor,
    action: /MainAction.editor,
    environment: { _ in () }
  ),
  MainReducer { _, action, _ in
    switch action {
    case .editor(_):
      return .none
    }
  }
)

import ComposableArchitecture

typealias MenuReducer = Reducer<MenuState, MenuAction, Void>

let menuReducer = MenuReducer { state, action, _ in
  switch action {
  case .importFromLibrary:
    return .none

  case .exportToLibrary:
    return .none

  case .updateBlur(let value):
    state.blur = value
    return .none

  case .updateSaturation(let value):
    state.saturation = value
    return .none

  case .updateHue(let value):
    state.hue = value
    return .none
  }
}

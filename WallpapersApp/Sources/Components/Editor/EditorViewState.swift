import ComposableArchitecture

struct EditorViewState: Equatable {
  let isImageLoaded: Bool
  let isPresentingImagePicker: Bool
  let isPresentingMenu: Bool
  let isPresentingAlert: AlertState<EditorAction>?

  init(state: EditorState) {
    isImageLoaded = state.canvas != nil
    isPresentingImagePicker = state.isPresentingImagePicker
    isPresentingMenu = state.isPresentingMenu
    isPresentingAlert = .state(for: state.isPresentingAlert)
  }
}

extension Optional where Wrapped == AlertState<EditorAction> {
  static func state(for alert: EditorState.Alert?) -> Self {
    switch alert {
    case .exportSuccess:
      return .exportSuccess

    case .exportFailure:
      return .exportFailure

    case .none:
      return nil
    }
  }
}

extension AlertState {
  static var exportSuccess: AlertState {
    AlertState(
      title: TextState("Wallpaper exported"),
      message: TextState("Cropped image exported to Photo Library")
    )
  }

  static var exportFailure: AlertState {
    AlertState(
      title: TextState("Error occured"),
      message: TextState("Unable to export wallpaper to Photo Library")
    )
  }
}

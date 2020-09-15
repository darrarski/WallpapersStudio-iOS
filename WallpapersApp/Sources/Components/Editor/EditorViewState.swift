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
      return AlertState(
        title: "Wallpaper exported",
        message: "Cropped image exported to Photo Library"
      )
    case .exportFailure:
      return AlertState(
        title: "Error occured",
        message: "Unable to export wallpaper to Photo Library"
      )
    case .none:
      return nil
    }
  }
}

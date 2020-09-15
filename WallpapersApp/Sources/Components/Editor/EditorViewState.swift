import ComposableArchitecture

struct EditorViewState: Equatable {
  let isImageLoaded: Bool
  let isPresentingImagePicker: Bool
  let isPresentingMenu: Bool
  let alert: AlertState<EditorAction>?

  init(state: EditorState) {
    isImageLoaded = state.canvas != nil
    isPresentingImagePicker = state.isPresentingImagePicker
    isPresentingMenu = state.isPresentingMenu
    switch state.isPresentingAlert {
    case .exportSuccess:
      alert = AlertState(
        title: "Wallpaper exported",
        message: "Cropped image exported to Photo Library"
      )
    case .exportFailure:
      alert = AlertState(
        title: "Error occured",
        message: "Unable to export wallpaper to Photo Library"
      )
    case .none:
      alert = nil
    }
  }
}

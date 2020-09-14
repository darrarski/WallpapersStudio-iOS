struct EditorViewState: Equatable {
  let isImageLoaded: Bool
  let isPresentingImagePicker: Bool
  let isPresentingMenu: Bool

  init(state: EditorState) {
    isImageLoaded = state.canvas != nil
    isPresentingImagePicker = state.isPresentingImagePicker
    isPresentingMenu = state.isPresentingMenu
  }
}

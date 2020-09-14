struct EditorViewState: Equatable {
  let isImageLoaded: Bool
  let isPresentingImagePicker: Bool
  let isPresentingConfig: Bool

  init(state: EditorState) {
    isImageLoaded = state.canvas != nil
    isPresentingImagePicker = state.isPresentingImagePicker
    isPresentingConfig = state.isPresentingConfig
  }
}

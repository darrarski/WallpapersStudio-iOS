struct MenuViewState: Equatable {
  let canExportToLibrary: Bool

  init(state: MenuState) {
    canExportToLibrary = state.isImageLoaded
  }
}

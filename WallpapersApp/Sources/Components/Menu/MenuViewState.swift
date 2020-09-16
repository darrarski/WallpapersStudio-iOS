import struct CoreGraphics.CGFloat

struct MenuViewState: Equatable {
  let canExportToLibrary: Bool
  let blurValue: CGFloat
  let blurString: String

  init(state: MenuState) {
    canExportToLibrary = state.isImageLoaded
    blurValue = state.blur
    blurString = String(format: "%.f %%", state.blur * 100)
  }
}

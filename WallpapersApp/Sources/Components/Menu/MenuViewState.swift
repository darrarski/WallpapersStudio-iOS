import struct CoreGraphics.CGFloat

struct MenuViewState: Equatable {
  let canExportToLibrary: Bool
  let blurValue: CGFloat
  let blurTextValue: String

  init(state: MenuState) {
    canExportToLibrary = state.isImageLoaded
    blurValue = state.blur
    blurTextValue = String(format: "%.f", state.blur * 100)
  }
}

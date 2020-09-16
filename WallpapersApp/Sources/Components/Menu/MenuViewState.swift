import struct CoreGraphics.CGFloat

struct MenuViewState: Equatable {
  let isExportDisabled: Bool
  let isFilteringDisabled: Bool
  let blur: SliderState
  let saturation: SliderState

  init(state: MenuState) {
    isExportDisabled = state.isImageLoaded == false
    isFilteringDisabled = state.isImageLoaded == false
    blur = SliderState(
      range: 0...1,
      value: state.blur,
      text: String(format: "%.f %%", state.blur * 100)
    )
    saturation = SliderState(
      range: 0...2,
      value: state.saturation,
      text: String(format: "%.f %%", state.saturation * 100)
    )
  }
}

extension MenuViewState {
  struct SliderState: Equatable {
    let range: ClosedRange<CGFloat>
    let value: CGFloat
    let text: String
  }
}

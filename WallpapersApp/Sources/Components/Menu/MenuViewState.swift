import struct CoreGraphics.CGFloat

struct MenuViewState: Equatable {
  let isExportDisabled: Bool
  let isFilteringDisabled: Bool
  let blur: SliderState
  let saturation: SliderState
  let hue: SliderState

  init(state: MenuState) {
    isExportDisabled = state.isImageLoaded == false
    isFilteringDisabled = state.isImageLoaded == false
    blur = SliderState(
      range: 0...1,
      value: state.blur,
      text: String(format: "%.f %%", state.blur * 100)
    )
    saturation = SliderState(
      range: 0...3,
      value: state.saturation,
      text: String(format: "%.f %%", state.saturation * 100)
    )
    hue = SliderState(
      range: 0...360,
      value: state.hue,
      text: String(format: "%.f°", state.hue)
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

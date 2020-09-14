import ComposableArchitecture
import CoreGraphics

typealias CanvasReducer = Reducer<CanvasState, CanvasAction, Void>

let canvasReducer = CanvasReducer { state, action, _ in
  switch action {
  case .updateSize(let size):
    let oldSize = state.size
    state.size = size
    if oldSize == .zero {
      return .init(value: .scaleToFill)
    } else {
      return .none
    }

  case .updateOffset(let delta):
    state.frame = state.frame.applying(.init(translationX: delta.x, y: delta.y))
    return .none

  case .updateScale(let delta):
    state.frame = state.frame.applying(.scaledBy(
      delta,
      anchor: CGPoint(x: state.size.width / 2, y: state.size.height / 2)
    ))
    return .none

  case .scaleToFill:
    state.frame = CGRect(
      origin: CGPoint(
        x: (state.image.size.width - state.size.width) / -2,
        y: (state.image.size.height - state.size.height) / -2
      ),
      size: state.image.size
    )
    let scale = max(
      state.size.width / state.image.size.width,
      state.size.height / state.image.size.height
    )
    state.frame = state.frame.applying(.scaledBy(scale, anchor: state.frame.center))
    return .none
  }
}

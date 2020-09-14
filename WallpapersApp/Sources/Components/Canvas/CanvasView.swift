import ComposableArchitecture
import SwiftUI

struct CanvasView: View {
  let store: Store<CanvasState, CanvasAction>
  let imageBorderWidth: CGFloat = 4

  var body: some View {
    GeometryReader { geometry in
      WithViewStore(store.scope(state: CanvasViewState.init(state:))) { viewStore in
        ZStack {
          Color(.systemBackground)
          Image(uiImage: viewStore.image)
            .resizable()
            .frame(size: viewStore.imageFrame.size)
            .padding(imageBorderWidth)
            .border(Color.accentColor, width: imageBorderWidth)
            .clipShape(RoundedRect(corners: .allCorners, radius: imageBorderWidth * 1.5))
            .offset(x: viewStore.imageFrame.minX, y: viewStore.imageFrame.minY)
        }
        .edgesIgnoringSafeArea(.all)
        .frame(size: geometry.size)
        .preference(key: CanvasSizePreferenceKey.self, value: geometry.sizeIgnoringSafeArea)
        .onPreferenceChange(CanvasSizePreferenceKey.self) { viewStore.send(.updateSize($0)) }
        .onDrag(updateOffset: { viewStore.send(.updateOffset(delta: $0)) })
        .onMagnify(updateScale: { viewStore.send(.updateScale(delta: $0)) })
      }
    }
  }
}

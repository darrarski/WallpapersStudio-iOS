import ComposableArchitecture
import SwiftUI

struct EditorView: View {
  let store: Store<EditorState, EditorAction>
  let imageBorder: CGFloat = 4

  var body: some View {
    GeometryReader { geometry in
      WithViewStore(store.scope(state: EditorViewState.init(state:))) { viewStore in
        ZStack {
          ZStack {
            Color(.systemBackground)
            if let image = viewStore.image {
              Image(uiImage: image)
                .resizable()
                .frame(
                  width: viewStore.imageFrame.width,
                  height: viewStore.imageFrame.height
                )
                .padding(imageBorder)
                .border(Color.accentColor, width: imageBorder)
                .clipShape(RoundedRect(
                  corners: .allCorners,
                  radius: CGSize(width: imageBorder * 1.5, height: imageBorder * 1.5)
                ))
                .offset(
                  x: (viewStore.imageFrame.width - geometry.sizeIgnoringSafeArea.width) / 2
                    + viewStore.imageFrame.minX,
                  y: (viewStore.imageFrame.height - geometry.sizeIgnoringSafeArea.height) / 2
                    + viewStore.imageFrame.minY
                )
            } else {
              Text("No image loaded")
            }
          }
          .edgesIgnoringSafeArea(.all)
          .frame(
            width: geometry.size.width,
            height: geometry.size.height
          )
          .onDrag(updateOffset: { delta in
            viewStore.send(.updateImageOffset(delta: delta))
          })
          .onMagnify(updateScale: { delta in
            viewStore.send(.updateImageScale(
              delta: delta,
              viewSize: geometry.sizeIgnoringSafeArea
            ))
          })
          .onTapGesture {
            withAnimation(.easeInOut) {
              viewStore.send(.toggleConfig)
            }
          }

          VStack {
            Spacer()
            if viewStore.isPresentingConfig {
              ConfigView(
                importAction: { viewStore.send(.presentImagePicker(true)) },
                exportAction: { viewStore.send(.exportImage(size: geometry.sizeIgnoringSafeArea)) }
              )
              .transition(
                AnyTransition
                  .move(edge: .bottom)
                  .combined(with: .offset(y: geometry.safeAreaInsets.bottom))
              )
            }
          }
        }
        .navigationBarHidden(true)
        .sheet(isPresented: viewStore.binding(
          get: \.isPresentingImagePicker,
          send: EditorAction.presentImagePicker
        )) {
          ImagePicker(onImport: { image in
            viewStore.send(.loadImage(image, viewSize: geometry.sizeIgnoringSafeArea))
          })
        }
      }
    }
  }
}

#if DEBUG
struct EditorView_Previews: PreviewProvider {
  static var previews: some View {
    EditorView(store: Store(
      initialState: EditorState(),
      reducer: editorReducer,
      environment: EditorEnvironment()
    ))
  }
}
#endif

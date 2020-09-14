import ComposableArchitecture
import SwiftUI

struct EditorView: View {
  let store: Store<EditorState, EditorAction>

  var body: some View {
    GeometryReader { geometry in
      WithViewStore(store.scope(state: EditorViewState.init(state:))) { viewStore in
        ZStack {
          ZStack {
            Color(.systemBackground)
              .edgesIgnoringSafeArea(.all)

            IfLetStore(
              store.scope(
                state: \.canvas,
                action: EditorAction.canvas
              ),
              then: CanvasView.init(store:)
            )

            if viewStore.isImageLoaded == false {
              Text("No image loaded")
            }
          }
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
                exportAction: { viewStore.send(.exportImage) }
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
            viewStore.send(.loadImage(image))
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
      environment: ()
    ))
  }
}
#endif

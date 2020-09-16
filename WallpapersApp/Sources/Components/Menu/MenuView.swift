import ComposableArchitecture
import SwiftUI

struct MenuView: View {
  let store: Store<MenuState, MenuAction>

  var body: some View {
    WithViewStore(store.scope(state: MenuViewState.init(state:))) { viewStore in
      VStack(alignment: .leading) {
        Button(action: { viewStore.send(.importFromLibrary) }) {
          HStack(alignment: .firstTextBaseline) {
            Image(systemName: "square.and.arrow.down")
            Text("Import photo from library")
          }
          .padding()
        }
        Button(action: { viewStore.send(.exportToLibrary) }) {
          HStack(alignment: .firstTextBaseline) {
            Image(systemName: "square.and.arrow.up")
            Text("Export wallpaper to library")
          }
          .padding()
        }
        .disabled(viewStore.canExportToLibrary == false)
        VStack {
          HStack(alignment: .firstTextBaseline) {
            Image(systemName: "drop")
            Text("Blur image")
            Spacer()
            Text("\(viewStore.blurTextValue) %")
          }
          Slider(value: viewStore.binding(get: \.blurValue, send: MenuAction.updateBlur))
            .disabled(viewStore.canExportToLibrary == false)
        }
        .padding()
      }
      .padding()
      .frame(maxWidth: .infinity)
      .background(
        VisualEffectView(effect: UIBlurEffect(style: .systemMaterial))
          .clipShape(
            RoundedRect(
              corners: [.topLeft, .topRight],
              radius: CGSize(width: 32, height: 32)
            )
          )
          .edgesIgnoringSafeArea(.all)
      )
    }
  }
}

#if DEBUG
struct MenuView_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      Spacer()
      MenuView(store: Store(
        initialState: MenuState(
          isImageLoaded: false,
          blur: 0
        ),
        reducer: menuReducer,
        environment: ()
      ))
    }
    .background(Color.blue.edgesIgnoringSafeArea(.all))
  }
}
#endif

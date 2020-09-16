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
        .disabled(viewStore.isExportDisabled)
        VStack {
          FilterSlider(
            icon: "drop",
            title: "Blur",
            valueString: viewStore.blur.text,
            value: viewStore.binding(get: \.blur.value, send: MenuAction.updateBlur),
            range: viewStore.blur.range
          )
        }
        .disabled(viewStore.isFilteringDisabled)
        .padding()
      }
      .padding()
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
    .background(Color.accentColor.edgesIgnoringSafeArea(.all))
  }
}
#endif

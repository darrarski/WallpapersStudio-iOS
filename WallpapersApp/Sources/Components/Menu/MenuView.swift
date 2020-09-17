import ComposableArchitecture
import SwiftUI

struct MenuView: View {
  let store: Store<MenuState, MenuAction>

  var body: some View {
    WithViewStore(store.scope(state: MenuViewState.init(state:))) { viewStore in
      VStack {
        HStack {
          Button(action: { viewStore.send(.importFromLibrary) }) {
            HStack(alignment: .firstTextBaseline) {
              Image(systemName: "square.and.arrow.down")
                .offset(x: 0, y: -2)
              Text("Import")
            }
            .padding()
          }
          Spacer()
          Button(action: { viewStore.send(.exportToLibrary) }) {
            HStack(alignment: .firstTextBaseline) {
              Text("Export")
              Image(systemName: "square.and.arrow.up")
                .offset(x: 0, y: -2)
            }
            .padding()
          }
          .disabled(viewStore.isExportDisabled)
          .opacity(viewStore.isExportDisabled ? 0.5 : 1)
        }
        VStack {
          FilterSlider(
            icon: "drop",
            title: "Blur",
            valueString: viewStore.blur.text,
            value: viewStore.binding(get: \.blur.value, send: MenuAction.updateBlur),
            range: viewStore.blur.range
          )
          FilterSlider(
            icon: "circle.righthalf.fill",
            title: "Saturation",
            valueString: viewStore.saturation.text,
            value: viewStore.binding(get: \.saturation.value, send: MenuAction.updateSaturation),
            range: viewStore.saturation.range
          )
          FilterSlider(
            icon: "triangle.righthalf.fill",
            title: "Hue",
            valueString: viewStore.hue.text,
            value: viewStore.binding(get: \.hue.value, send: MenuAction.updateHue),
            range: viewStore.hue.range
          )
        }
        .disabled(viewStore.isFilteringDisabled)
        .opacity(viewStore.isFilteringDisabled ? 0.5 : 1)
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
      .frame(maxWidth: 640)
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
          blur: 0,
          saturation: 1,
          hue: 0
        ),
        reducer: menuReducer,
        environment: ()
      ))
    }
    .frame(maxWidth: .infinity)
    .background(Color.accentColor.edgesIgnoringSafeArea(.all))
  }
}
#endif

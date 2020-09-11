import SwiftUI

struct ConfigView: View {
  var importAction: () -> Void
  var exportAction: () -> Void

  var body: some View {
    VStack(alignment: .leading) {
      Button(action: importAction) {
        HStack(alignment: .firstTextBaseline) {
          Image(systemName: "square.and.arrow.down")
          Text("Import photo from library")
        }
        .padding()
      }
      Button(action: exportAction) {
        HStack(alignment: .firstTextBaseline) {
          Image(systemName: "square.and.arrow.up")
          Text("Export wallpaper to library")
        }
        .padding()
      }
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

#if DEBUG
struct ConfigView_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      Spacer()
      ConfigView(
        importAction: {},
        exportAction: {}
      )
    }
    .background(Color.blue.edgesIgnoringSafeArea(.all))
  }
}
#endif

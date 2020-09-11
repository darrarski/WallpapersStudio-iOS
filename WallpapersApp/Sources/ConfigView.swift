import SwiftUI

struct ConfigView: View {
  var importAction: () -> Void

  var body: some View {
    ZStack {
      Button(action: importAction) {
        HStack {
          Image(systemName: "square.and.arrow.down")
          Text("Import photo")
        }
        .padding()
      }
      .frame(height: 250)
    }
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
      ConfigView(importAction: {})
    }
    .background(Color.blue.edgesIgnoringSafeArea(.all))
  }
}
#endif

import SwiftUI
import UIKit

struct VisualEffectView: UIViewRepresentable {
  var effect: UIVisualEffect

  func makeUIView(context: Context) -> UIVisualEffectView {
    UIVisualEffectView(effect: effect)
  }

  func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
    uiView.effect = effect
  }
}

#if DEBUG
struct VisualEffectView_Previews: PreviewProvider {
  static var previews: some View {
    ZStack {
      Color.blue
      Text("Hello, World!")
        .multilineTextAlignment(.center)
        .padding(16)
        .background(
          VisualEffectView(effect: UIBlurEffect(style: .systemMaterial))
            .cornerRadius(8)
        )
    }
    .previewLayout(.fixed(width: 128, height: 128))
  }
}
#endif

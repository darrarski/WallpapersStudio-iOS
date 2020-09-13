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

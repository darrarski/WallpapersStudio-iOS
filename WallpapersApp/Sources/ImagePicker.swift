import UIKit
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
  @Binding var image: UIImage?
  @Environment(\.presentationMode) private var presentationMode

  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }

  func makeUIViewController(context: Context) -> UIImagePickerController {
    let controller = UIImagePickerController()
    controller.delegate = context.coordinator
    return controller
  }

  func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

extension ImagePicker {
  final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    init(_ picker: ImagePicker) {
      self.picker = picker
      super.init()
    }

    func imagePickerController(
      _ controller: UIImagePickerController,
      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
      picker.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
      picker.presentationMode.wrappedValue.dismiss()
    }

    private let picker: ImagePicker
  }
}

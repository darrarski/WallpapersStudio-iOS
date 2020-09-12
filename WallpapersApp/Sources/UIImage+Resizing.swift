import UIKit

extension UIImage {
  func resized(to size: CGSize) -> UIImage {
    UIGraphicsImageRenderer(size: size).image { _ in
      // TODO: maintain aspect ratio?
      draw(in: CGRect(origin: .zero, size: size))
    }
  }
}

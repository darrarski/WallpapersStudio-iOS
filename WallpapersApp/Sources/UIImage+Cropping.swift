import UIKit

extension UIImage {
  func cropped(to rect: CGRect) -> UIImage? {
    let croppingRect = rect
      .applying(.rotated(angle: imageOrientation.rotationAngle, anchor: rect.center))
      .applying(.scaledBy(scale))
    guard let cgImage = cgImage?.cropping(to: croppingRect) else {
      return nil
    }
    return UIImage(
      cgImage: cgImage,
      scale: scale,
      orientation: imageOrientation
    )
  }

  func croppingRect(
    size: CGSize,
    offset: CGPoint,
    scale: CGFloat
  ) -> CGRect {
    let imageRect = CGRect(origin: .zero, size: self.size.applying(.scaledBy(self.scale)))
      .applying(.rotated(angle: imageOrientation.rotationAngle, anchor: .zero))
    let croppingSize = size.applying(.scaledBy(1 / scale))
    let croppingOffset = offset.applying(.scaledBy(1 / scale))
    let croppingOrigin = CGPoint(
      x: (imageRect.size.width - croppingSize.width) / 2 - croppingOffset.x,
      y: (imageRect.size.height - croppingSize.height) / 2 - croppingOffset.y
    )
    return CGRect(origin: croppingOrigin, size: croppingSize)
  }
}

import UIKit

extension UIImage {
  func cropped(to rect: CGRect) -> UIImage? {
    let croppingRect = rect.scaled(by: scale)
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
    let imageSize = self.size.scaled(by: self.scale)
    let croppingSize = size.scaled(by: 1 / scale)
    let croppingOffset = offset.scaled(by: 1 / scale)
    let croppingOrigin = CGPoint(
      x: (imageSize.width - croppingSize.width) / 2 - croppingOffset.x,
      y: (imageSize.height - croppingSize.height) / 2 - croppingOffset.y
    )
    return CGRect(origin: croppingOrigin, size: croppingSize)
  }
}

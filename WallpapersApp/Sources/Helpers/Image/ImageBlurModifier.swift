import CoreImage
import class UIKit.UIImage

typealias ImageBlurModifier = (UIImage, CGFloat) -> UIImage?

private let sharedCIContext = CIContext(options: nil)

let defaultImageBlurModifier: ImageBlurModifier = { image, radius in
  guard let inputCIImage = CIImage(image: image) else { return nil }

  guard let blurFilter = CIFilter(name: "CIGaussianBlur") else { return nil }
  blurFilter.setValue(inputCIImage, forKey: kCIInputImageKey)
  blurFilter.setValue(radius, forKey: kCIInputRadiusKey)

  guard let cropFilter = CIFilter(name: "CICrop") else { return nil }
  cropFilter.setValue(blurFilter.outputImage, forKey: kCIInputImageKey)
  cropFilter.setValue(CIVector(cgRect: inputCIImage.extent), forKey: "inputRectangle")

  guard let outputCIImage = cropFilter.outputImage else { return nil }
  guard let outputCGImage = sharedCIContext.createCGImage(outputCIImage, from: outputCIImage.extent) else { return nil }
  return UIImage(cgImage: outputCGImage, scale: image.scale, orientation: image.imageOrientation)
}

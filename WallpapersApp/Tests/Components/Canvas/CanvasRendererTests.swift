import XCTest
import SnapshotTesting
@testable import WallpapersApp

final class CanvasRendererTests: XCTestCase {
  func testRendering() {
    let image = testImage()
    let state = CanvasState(
      size: CGSize(width: image.size.width / 2, height: image.size.height / 2),
      image: testImage(),
      frame: CGRect(
        origin: CGPoint(x: -image.size.width / 4, y: -image.size.width / 4),
        size: image.size
      ),
      blur: 0.2,
      saturation: 1.5,
      hue: 60
    )

    assertSnapshot(
      matching: defaultCanvasRenderer(state),
      as: .image(precision: 0.99, scale: 1)
    )
  }

  private func testImage() -> UIImage {
    let bundle = Bundle(for: CanvasRendererTests.self)
    let path = bundle.path(forResource: "test_image_1", ofType: "jpeg")!
    let data = try! Data(contentsOf: URL(fileURLWithPath: path))
    return UIImage(data: data)!
  }
}

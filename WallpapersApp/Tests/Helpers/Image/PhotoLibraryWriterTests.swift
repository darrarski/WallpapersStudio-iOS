import XCTest
@testable import WallpapersApp

final class PhotoLibraryWriterTests: XCTestCase {
  var sut: PhotoLibraryWriter!
  var writeFunc: PhotoLibraryWriter.WriteFunction!
  var didCallWriteFunc: (image: UIImage, target: Any?, selector: Selector?)?

  override func setUp() {
    writeFunc = { image, target, selector, _ in
      self.didCallWriteFunc = (image, target, selector)
    }
    sut = PhotoLibraryWriter(writeFunction: writeFunc)
  }

  override func tearDown() {
    sut = nil
    writeFunc = nil
    didCallWriteFunc = nil
  }

  func testWriting() {
    let image = UIImage()
    var didComplete = false
    var didFailWithError: Error?
    sut.write(image: image) { error in
      didComplete = true
      didFailWithError = error
    }

    XCTAssertNotNil(didCallWriteFunc)
    XCTAssertEqual(didCallWriteFunc?.image, image)

    let target = didCallWriteFunc?.target as? NSObject
    let selector = didCallWriteFunc?.selector
    target?.perform(selector, with: image, with: nil)

    XCTAssertTrue(didComplete)
    XCTAssertNil(didFailWithError)
  }

  func testWritingFailure() {
    let image = UIImage()
    let error = NSError(domain: "test", code: 1234, userInfo: nil)
    var didComplete = false
    var didFailWithError: Error?
    sut.write(image: image) { error in
      didComplete = true
      didFailWithError = error
    }

    XCTAssertNotNil(didCallWriteFunc)
    XCTAssertEqual(didCallWriteFunc?.image, image)

    let target = didCallWriteFunc?.target as? NSObject
    let selector = didCallWriteFunc?.selector
    target?.perform(selector, with: image, with: error)

    XCTAssertTrue(didComplete)
    XCTAssertEqual(didFailWithError as NSError?, error)
  }
}

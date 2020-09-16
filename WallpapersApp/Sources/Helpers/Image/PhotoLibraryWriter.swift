import Foundation
import class UIKit.UIImage
import func UIKit.UIImageWriteToSavedPhotosAlbum

protocol PhotoLibraryWriting {
  func write(image: UIImage, completion: @escaping (Error?) -> Void)
}

struct PhotoLibraryWriter: PhotoLibraryWriting {
  typealias WriteFunction = (UIImage, Any?, Selector?, UnsafeMutableRawPointer?) -> Void
  let writeFunction: WriteFunction

  init(writeFunction: @escaping WriteFunction = UIImageWriteToSavedPhotosAlbum) {
    self.writeFunction = writeFunction
  }

  func write(image: UIImage, completion: @escaping (Error?) -> Void) {
    var handler: CompletionHandler?
    handler = CompletionHandler { error in
      completion(error)
      _ = handler
    }
    writeFunction(
      image,
      handler,
      #selector(CompletionHandler.image(_:error:context:)),
      nil
    )
  }

  private class CompletionHandler: NSObject {
    init(completion: @escaping (Error?) -> Void) {
      self.completion = completion
      super.init()
    }

    let completion: (Error?) -> Void

    @objc func image(_ image: UIImage, error: Error?, context: UnsafeRawPointer) {
      completion(error)
    }
  }
}

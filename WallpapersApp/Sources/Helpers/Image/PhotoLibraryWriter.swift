import Combine
import ComposableArchitecture
import class UIKit.UIImage
import func UIKit.UIImageWriteToSavedPhotosAlbum

typealias PhotoLibraryWriter = (UIImage) -> AnyPublisher<Void, Error>

let defaultPhotoLibraryWriter: PhotoLibraryWriter = { image in
  final class SaveImage: NSObject {
    init(_ image: UIImage, completion: @escaping (Error?) -> Void) {
      self.completion = completion
      super.init()
      UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:error:context:)), nil)
    }

    private let completion: (Error?) -> Void

    @objc private func image(_ image: UIImage, error: Error?, context: UnsafeRawPointer) {
      completion(error)
    }
  }

  return Effect<Void, Error>.run { subscriber in
    var writer: SaveImage? = SaveImage(image, completion: { error in
      if let error = error {
        subscriber.send(completion: .failure(error))
      } else {
        subscriber.send(())
        subscriber.send(completion: .finished)
      }
    })
    return AnyCancellable { writer = nil }
  }.eraseToAnyPublisher()
}

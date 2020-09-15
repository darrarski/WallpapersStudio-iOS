import ComposableArchitecture

struct EditorEnvironment {
  var renderCanvas: CanvasRenderer = defaultCanvasRenderer
  var savePhoto: PhotoLibraryWriter = defaultPhotoLibraryWriter
  var blurImage: ImageBlurModifier = defaultImageBlurModifier
  var filterQueue: AnySchedulerOf<DispatchQueue> = .init(DispatchQueue.global(qos: .userInteractive))
  var mainQueue: AnySchedulerOf<DispatchQueue> = .init(DispatchQueue.main)
}

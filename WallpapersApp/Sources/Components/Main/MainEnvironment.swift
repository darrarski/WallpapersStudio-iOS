import TelemetryClient

struct MainEnvironment {
  var renderCanvas: CanvasRenderer = defaultCanvasRenderer
  var photoLibraryWriter: PhotoLibraryWriting = PhotoLibraryWriter()
  var appTelemetry: AppTelemetry = AppTelemetry()
}

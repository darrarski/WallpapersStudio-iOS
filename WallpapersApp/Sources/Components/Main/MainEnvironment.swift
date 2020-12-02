import TelemetryClient

struct MainEnvironment {
  var renderCanvas: CanvasRenderer = defaultCanvasRenderer
  var photoLibraryWriter: PhotoLibraryWriting = PhotoLibraryWriter()
  var appTelemetry: AppTelemetry = AppTelemetry()
}

extension MainEnvironment {
  var editorEnv: EditorEnvironment {
    EditorEnvironment(
      renderCanvas: renderCanvas,
      photoLibraryWriter: photoLibraryWriter
    )
  }
}

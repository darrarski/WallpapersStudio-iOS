struct MainEnvironment {
  var renderCanvas: CanvasRenderer = defaultCanvasRenderer
  var photoLibraryWriter: PhotoLibraryWriting = PhotoLibraryWriter()
}

extension MainEnvironment {
  var editorEnv: EditorEnvironment {
    EditorEnvironment(
      renderCanvas: renderCanvas,
      photoLibraryWriter: photoLibraryWriter
    )
  }
}

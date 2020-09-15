struct MainEnvironment {
  var renderCanvas: CanvasRenderer = defaultCanvasRenderer
  var savePhoto: PhotoLibraryWriter = defaultPhotoLibraryWriter
}

extension MainEnvironment {
  var editorEnv: EditorEnvironment {
    EditorEnvironment(
      renderCanvas: renderCanvas,
      savePhoto: savePhoto
    )
  }
}

struct MainEnvironment {
  var renderCanvas: CanvasRenderer = defaultCanvasRenderer
  var savePhoto: PhotoLibraryWriter = defaultPhotoLibraryWriter
  var blurImage: ImageBlurModifier = defaultImageBlurModifier
}

extension MainEnvironment {
  var editorEnv: EditorEnvironment {
    EditorEnvironment(
      renderCanvas: renderCanvas,
      savePhoto: savePhoto,
      blurImage: blurImage
    )
  }
}

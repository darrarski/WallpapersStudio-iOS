struct MainEnvironment {
  var renderCanvas: CanvasRenderer = defaultCanvasRenderer
}

extension MainEnvironment {
  var editorEnv: EditorEnvironment {
    EditorEnvironment(renderCanvas: renderCanvas)
  }
}

extension Analytics {
  static var `default`: Analytics = disabled ? .stub : .standard
  private static var disabled: Bool { isRunningTests || isRunningPreviews || isDebugMode }
}

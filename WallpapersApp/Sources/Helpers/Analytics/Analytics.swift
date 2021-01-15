struct Analytics {
  var setup: () -> Void
  var send: (AnalyticsEvent) -> Void
}

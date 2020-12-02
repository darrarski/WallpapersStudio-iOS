import TelemetryClient

struct AppTelemetry {
  static var initialize: (TelemetryManagerConfiguration) -> Void = TelemetryManager.initialize(with:)
}

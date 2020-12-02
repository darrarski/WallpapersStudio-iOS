import TelemetryClient

struct AppTelemetry {
  static var initialize: (TelemetryManagerConfiguration) -> Void = TelemetryManager.initialize(with:)
  static var send: (Signal) -> Void = TelemetryManager.send
}

extension AppTelemetry {
  enum Signal: String {
    case appStart
  }
}

extension TelemetryManager {
  static func send(_ signal: AppTelemetry.Signal) { send(signal.rawValue) }
}

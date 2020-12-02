import TelemetryClient

struct AppTelemetry {
  enum Signal: String {
    case appStart
  }

  static var initialize: (TelemetryManagerConfiguration) -> Void = TelemetryManager.initialize(with:)
  static var send: (Signal) -> Void = TelemetryManager.send
}

extension TelemetryManager {
  static func send(_ signal: AppTelemetry.Signal) { send(signal.rawValue) }
}

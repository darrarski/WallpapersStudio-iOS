import TelemetryClient

struct AppTelemetry {
  static var initialize: (TelemetryManagerConfiguration) -> Void = TelemetryManager.initialize(with:)
  static var send: (Signal) -> Void = TelemetryManager.send
}

extension AppTelemetry {
  struct Signal: Equatable {
    var name: String
    var payload: [String: String] = [:]

    static let appStart = Signal(name: "appStart")
  }
}

extension TelemetryManager {
  static func send(_ signal: AppTelemetry.Signal) {
    send(signal.name, with: signal.payload)
  }
}

import TelemetryClient

struct AppTelemetry {
  static var defaultInitializer: (TelemetryManagerConfiguration) -> Void = TelemetryManager.initialize(with:)
  static var defaultSend: (Signal) -> Void = TelemetryManager.send

  var initialize: (TelemetryManagerConfiguration) -> Void = Self.defaultInitializer
  var send: (Signal) -> Void = Self.defaultSend
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

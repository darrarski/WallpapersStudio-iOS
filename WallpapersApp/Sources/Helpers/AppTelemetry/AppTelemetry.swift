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

    static var appStart: Signal {
      Signal(name: "appStart")
    }

    static func toggleMenu(_ present: Bool) -> Signal {
      Signal(name: "toggleMenu", payload: ["presented": format(present)])
    }

    static var importFromLibrary: Signal {
      Signal(name: "importFromLibrary")
    }
  }
}

private extension TelemetryManager {
  static func send(_ signal: AppTelemetry.Signal) {
    send(signal.name, with: signal.payload)
  }
}

private func format(_ bool: Bool) -> String {
  bool ? "true" : "false"
}

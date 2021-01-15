import TelemetryClient

extension Analytics {
  static var standard: Analytics {
    Analytics(
      setup: {
        TelemetryManager.initialize(
          with: TelemetryManagerConfiguration(
            appID: "YOUR-APP-UNIQUE-IDENTIFIER"
          )
        )
      },
      send: { event in
        TelemetryManager.send(
          event.name,
          with: event.payload
        )
      }
    )
  }
}

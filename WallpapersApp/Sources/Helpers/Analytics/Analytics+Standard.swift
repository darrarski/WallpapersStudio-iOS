import Mixpanel
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
        Mixpanel.initialize(token: "MIXPANEL_TOKEN")
        Mixpanel.mainInstance().serverURL = "https://api-eu.mixpanel.com"
      },
      send: { event in
        TelemetryManager.send(
          event.name,
          with: event.payload
        )
        Mixpanel.mainInstance().track(
          event: event.name,
          properties: event.payload
        )
      }
    )
  }
}

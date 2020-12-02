import XCTest
@testable import WallpapersApp
import TelemetryClient

final class MainAppTests: XCTestCase {
  func testAppTelemetryInitialization() {
    let appTelemetryDefaultInitializer = AppTelemetry.initialize
    var didInitializeWithConfig: TelemetryManagerConfiguration?
    AppTelemetry.initialize = { didInitializeWithConfig = $0 }
    let appTelemetryDefaultSend = AppTelemetry.send
    var didSendSignals = [AppTelemetry.Signal]()
    AppTelemetry.send = { didSendSignals.append($0) }
    defer {
      AppTelemetry.initialize = appTelemetryDefaultInitializer
      AppTelemetry.send = appTelemetryDefaultSend
    }

    _ = MainApp()

    XCTAssertEqual(didInitializeWithConfig?.telemetryAppID, "YOUR-APP-UNIQUE-IDENTIFIER")
    XCTAssertEqual(didSendSignals, [.appStart])
  }
}

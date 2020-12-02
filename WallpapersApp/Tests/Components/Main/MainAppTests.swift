import XCTest
@testable import WallpapersApp
import TelemetryClient

final class MainAppTests: XCTestCase {
  func testAppTelemetryInitialization() {
    let appTelemetryDefaultInitializer = AppTelemetry.defaultInitializer
    var didInitializeWithConfig: TelemetryManagerConfiguration?
    AppTelemetry.defaultInitializer = { didInitializeWithConfig = $0 }
    let appTelemetryDefaultSend = AppTelemetry.defaultSend
    var didSendSignals = [AppTelemetry.Signal]()
    AppTelemetry.defaultSend = { didSendSignals.append($0) }
    defer {
      AppTelemetry.defaultInitializer = appTelemetryDefaultInitializer
      AppTelemetry.defaultSend = appTelemetryDefaultSend
    }

    _ = MainApp()

    XCTAssertEqual(didInitializeWithConfig?.telemetryAppID, "YOUR-APP-UNIQUE-IDENTIFIER")
    XCTAssertEqual(didSendSignals, [.appStart])
  }
}

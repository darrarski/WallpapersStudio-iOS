import XCTest
@testable import WallpapersApp
import TelemetryClient

final class MainAppTests: XCTestCase {
  func testAppTelemetryInitialization() {
    let appTelemetryDefaultInitializer = AppTelemetry.initialize
    var didInitializeWithConfig: TelemetryManagerConfiguration?
    AppTelemetry.initialize = { didInitializeWithConfig = $0 }
    defer { AppTelemetry.initialize = appTelemetryDefaultInitializer }

    _ = MainApp()

    XCTAssertEqual(didInitializeWithConfig?.telemetryAppID, "YOUR-APP-UNIQUE-IDENTIFIER")
  }
}

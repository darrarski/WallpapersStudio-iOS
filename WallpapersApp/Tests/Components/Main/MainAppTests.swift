import XCTest
@testable import WallpapersApp
import TelemetryClient

final class MainAppTests: XCTestCase {
  func testAnalytics() {
    let defaultAnalytics = Analytics.default
    defer { Analytics.default = defaultAnalytics }
    var didSetup = false
    var didSendEvents = [AnalyticsEvent]()
    Analytics.default = Analytics(
      setup: { didSetup = true },
      send: { didSendEvents.append($0) }
    )

    _ = MainApp()

    XCTAssertTrue(didSetup)
    XCTAssertEqual(didSendEvents, [.appStart])
  }
}

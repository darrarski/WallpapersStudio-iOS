import Foundation

var isRunningTests: Bool {
  ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
}

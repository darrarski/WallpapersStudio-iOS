import Foundation

public var isRunningPreviews: Bool {
  ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] != nil
}

import Foundation

public var isDebugMode: Bool {
  #if DEBUG
  return true
  #else
  return false
  #endif
}

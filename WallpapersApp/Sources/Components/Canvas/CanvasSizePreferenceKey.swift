import SwiftUI

struct CanvasSizePreferenceKey: PreferenceKey {
  static let defaultValue = CGSize.zero
  static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
    value = nextValue()
  }
}

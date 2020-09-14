import XCTest
import SnapshotTesting
@testable import WallpapersApp
import ComposableArchitecture
import SwiftUI

final class EditorViewTests: XCTestCase {
  func testSnapshotWithoutLoadedImage() {
    assertSnapshot(
      matching: EditorView(store: Store(
        initialState: EditorState(),
        reducer: .empty,
        environment: ()
      )),
      as: .image(
        drawHierarchyInKeyWindow: true,
        layout: .device(config: .iPhoneXr),
        traits: .init(userInterfaceStyle: .light)
      )
    )
  }
}

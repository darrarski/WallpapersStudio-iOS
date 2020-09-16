import XCTest
import SnapshotTesting
@testable import WallpapersApp
import ComposableArchitecture
import SwiftUI

final class EditorViewTests: XCTestCase {
  func testPreviewSnapshot() {
    assertSnapshot(
      matching: EditorView_Previews.previews,
      as: .image(
        drawHierarchyInKeyWindow: true,
        layout: .device(config: .iPhoneXr),
        traits: .init(userInterfaceStyle: .light)
      )
    )
  }

  func testSnapshotWithLoadedImage() {
    assertSnapshot(
      matching: EditorView(store: Store(
        initialState: EditorState(
          image: UIImage(),
          canvas: CanvasState(
            size: .zero,
            image: UIImage(),
            frame: .zero
          )
        ),
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

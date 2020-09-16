import XCTest
import SnapshotTesting
@testable import WallpapersApp
import ComposableArchitecture
import SwiftUI

final class MenuViewTests: XCTestCase {
  func testPreviewSnapshot() {
    assertSnapshot(
      matching: snapshotView(MenuView_Previews.previews),
      as: .image(
        drawHierarchyInKeyWindow: true,
        layout: .device(config: .iPhoneXr),
        traits: .init(userInterfaceStyle: .light)
      )
    )
  }

  func testSnapshotWithLoadedImage() {
    assertSnapshot(
      matching: snapshotView(
        MenuView(store: Store(
          initialState: MenuState(
            isImageLoaded: true,
            blur: 0.33
          ),
          reducer: .empty,
          environment: ()
        ))
      ),
      as: .image(
        drawHierarchyInKeyWindow: true,
        layout: .device(config: .iPhoneXr),
        traits: .init(userInterfaceStyle: .light)
      )
    )
  }

  private func snapshotView<Content: View>(_ content: Content) -> some View {
    VStack {
      Spacer()
      content
    }
    .background(
      Color.accentColor
        .edgesIgnoringSafeArea(.all)
    )
  }
}

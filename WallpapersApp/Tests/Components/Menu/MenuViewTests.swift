import XCTest
import SnapshotTesting
@testable import WallpapersApp
import ComposableArchitecture
import SwiftUI

final class MenuViewTests: XCTestCase {
  func testSnapshotWithoutLoadedImage() {
    assertSnapshot(
      matching: snapshotView(
        MenuView(store: Store(
          initialState: MenuState(
            isImageLoaded: false
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

  func testSnapshotWithLoadedImage() {
    assertSnapshot(
      matching: snapshotView(
        MenuView(store: Store(
          initialState: MenuState(
            isImageLoaded: true
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

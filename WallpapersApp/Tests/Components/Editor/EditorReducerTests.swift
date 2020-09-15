import XCTest
@testable import WallpapersApp
import Combine
import ComposableArchitecture

final class EditorReducerTests: XCTestCase {
  func testPresentImagePicker() {
    let store = TestStore(
      initialState: EditorState(),
      reducer: editorReducer,
      environment: EditorEnvironment()
    )

    store.assert(
      .send(.menu(.importFromLibrary)),
      .receive(.presentImagePicker(true)) {
        $0.isPresentingImagePicker = true
      },
      .send(.presentImagePicker(false)) {
        $0.isPresentingImagePicker = false
      }
    )
  }

  func testToggleMenu() {
    let store = TestStore(
      initialState: EditorState(),
      reducer: editorReducer,
      environment: EditorEnvironment()
    )

    store.assert(
      .send(.toggleMenu) {
        $0.isPresentingMenu.toggle()
      },
      .send(.toggleMenu) {
        $0.isPresentingMenu.toggle()
      }
    )
  }

  func testLoadImage() {
    let store = TestStore(
      initialState: EditorState(),
      reducer: editorReducer,
      environment: EditorEnvironment()
    )

    let image1 = image(color: .red, size: CGSize(width: 6, height: 4))
    let image2 = image(color: .blue, size: CGSize(width: 3, height: 6))

    store.assert(
      .send(.loadImage(image1)) {
        $0.image = image1
        $0.canvas = CanvasState(
          size: .zero,
          image: image1,
          frame: CGRect(origin: .zero, size: image1.size)
        )
        $0.menu.isImageLoaded = true
      },
      .receive(.canvas(.scaleToFill)) {
        $0.canvas?.frame.size = .zero
      },
      .send(.canvas(.updateSize(CGSize(width: 3, height: 4)))) {
        $0.canvas?.size = CGSize(width: 3, height: 4)
      },
      .receive(.canvas(.scaleToFill)) {
        $0.canvas?.frame.origin = CGPoint(x: -1.5, y: 0)
        $0.canvas?.frame.size = image1.size
      },
      .send(.loadImage(image2)) {
        $0.image = image2
        $0.canvas?.image = image2
        $0.canvas?.frame.origin = .zero
        $0.canvas?.frame.size = image2.size
      },
      .receive(.canvas(.scaleToFill)) {
        $0.canvas?.frame.origin = CGPoint(x: 0, y: -1)
      }
    )
  }

  func testExportingImageWhenNoImageLoaded() {
    let store = TestStore(
      initialState: EditorState(),
      reducer: editorReducer,
      environment: EditorEnvironment()
    )

    store.assert(
      .send(.menu(.exportToLibrary)),
      .receive(.exportImage)
    )
  }

  func testExportingImage() {
    var didRenderCanvas: [CanvasState] = []
    let renderedCanvas: UIImage = image(color: .blue, size: CGSize(width: 4, height: 6))
    var didSavePhoto: [UIImage] = []
    let savePhotoSubject = PassthroughSubject<Void, Error>()
    let initialState = EditorState(
      canvas: CanvasState(
        size: CGSize(width: 4, height: 6),
        image: image(color: .red, size: CGSize(width: 40, height: 60)),
        frame: CGRect(
          origin: CGPoint(x: -5, y: -10),
          size: CGSize(width: 20, height: 20)
        )
      )
    )
    let store = TestStore(
      initialState: initialState,
      reducer: editorReducer,
      environment: EditorEnvironment(
        renderCanvas: { canvas -> UIImage in
          didRenderCanvas.append(canvas)
          return renderedCanvas
        },
        savePhoto: { image in
          didSavePhoto.append(image)
          return savePhotoSubject.eraseToAnyPublisher()
        }
      )
    )

    store.assert(
      .send(.menu(.exportToLibrary)),
      .receive(.exportImage),
      .do {
        XCTAssertEqual(didRenderCanvas, [initialState.canvas!])
        XCTAssertEqual(didSavePhoto, [renderedCanvas])
        savePhotoSubject.send(())
      },
      .receive(.didExportImage) {
        $0.isPresentingAlert = .exportSuccess
      },
      .do { savePhotoSubject.send(completion: .finished) },
      .send(.dismissAlert) {
        $0.isPresentingAlert = nil
      }
    )
  }

  func testExportingImageFailure() {
    let savePhotoSubject = PassthroughSubject<Void, Error>()
    let error = NSError(domain: "test", code: 1234, userInfo: nil)
    let store = TestStore(
      initialState: EditorState(
        canvas: CanvasState(size: .zero, image: UIImage(), frame: .zero)
      ),
      reducer: editorReducer,
      environment: EditorEnvironment(
        renderCanvas: { _ in UIImage() },
        savePhoto: { _ in savePhotoSubject.eraseToAnyPublisher() }
      )
    )

    store.assert(
      .send(.menu(.exportToLibrary)),
      .receive(.exportImage),
      .do { savePhotoSubject.send(completion: .failure(error)) },
      .receive(.didFailExportingImage) {
        $0.isPresentingAlert = .exportFailure
      },
      .send(.dismissAlert) {
        $0.isPresentingAlert = nil
      }
    )
  }

  private func image(color: UIColor, size: CGSize) -> UIImage {
    UIGraphicsImageRenderer(size: size).image { context in
      color.setFill()
      context.fill(CGRect(origin: .zero, size: size))
    }
  }
}

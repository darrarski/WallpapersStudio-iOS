import SwiftUI

struct EditorView: View {
  @State var isPresentingImagePicker: Bool = false
  @State var isPresentingConfig: Bool = true
  @State var image: UIImage?
  @State var imageFrame: CGRect = .zero

  var body: some View {
    GeometryReader { geometry in
      ZStack {
        ZStack {
          Color(.systemBackground)
          if let image = image {
            Image(uiImage: image)
              .resizable()
              .frame(
                width: imageFrame.width,
                height: imageFrame.height
              )
              .padding(4)
              .border(Color.accentColor, width: 4)
              .clipShape(RoundedRect(
                corners: .allCorners,
                radius: CGSize(width: 6, height: 6)
              ))
              .offset(
                x: (imageFrame.width - geometry.sizeIgnoringSafeArea.width) / 2 + imageFrame.minX,
                y: (imageFrame.height - geometry.sizeIgnoringSafeArea.height) / 2 + imageFrame.minY
              )
          } else {
            Text("No image loaded")
          }
        }
        .edgesIgnoringSafeArea(.all)
        .frame(
          width: geometry.size.width,
          height: geometry.size.height
        )
        .onDrag(updateOffset: { delta in
          self.imageFrame = self.imageFrame
            .applying(.init(translationX: delta.x, y: delta.y))
        })
        .onMagnify(updateScale: { delta in
          self.imageFrame = self.imageFrame
            .applying(.scaledBy(
              delta,
              anchor: CGPoint(
                x: geometry.sizeIgnoringSafeArea.width / 2,
                y: geometry.sizeIgnoringSafeArea.height / 2
              )
            ))
        })
        .onTapGesture {
          withAnimation(.easeInOut) {
            self.isPresentingConfig.toggle()
          }
        }

        VStack {
          Spacer()
          if isPresentingConfig {
            ConfigView(
              importAction: { self.isPresentingImagePicker = true },
              exportAction: { self.exportImage(size: geometry.sizeIgnoringSafeArea) }
            )
            .transition(
              AnyTransition
                .move(edge: .bottom)
                .combined(with: .offset(y: geometry.safeAreaInsets.bottom))
            )
          }
        }
      }
      .navigationBarHidden(true)
      .sheet(isPresented: $isPresentingImagePicker) {
        ImagePicker(onImport: { self.loadImage($0, fill: geometry.sizeIgnoringSafeArea) })
      }
    }
  }

  private func loadImage(_ image: UIImage, fill size: CGSize) {
    self.image = image
    self.imageFrame = CGRect(
      origin: CGPoint(
        x: (image.size.width - size.width) / -2,
        y: (image.size.height - size.height) / -2
      ),
      size: image.size
    )
    self.imageFrame = self.imageFrame
      .applying(.scaledBy(
        max(size.width / image.size.width, size.height / image.size.height),
        anchor: self.imageFrame.center
      ))
    self.imageFrame = self.imageFrame.applying(.scaledBy(1.1, anchor: self.imageFrame.center))
  }

  private func exportImage(size: CGSize) {
    guard let image = self.image else { return }
    var renderingBounds = CGRect(origin: .zero, size: size)
    renderingBounds = renderingBounds.applying(.scaledBy(1.1, anchor: renderingBounds.center))
    let renderer = UIGraphicsImageRenderer(bounds: renderingBounds)
    let exportedImage = renderer.image { context in
      image.draw(in: imageFrame)
    }

    // TODO: save to photo library
    // UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    loadImage(exportedImage, fill: size)
  }
}

#if DEBUG
struct EditorView_Previews: PreviewProvider {
  static var previews: some View {
    EditorView()
  }
}
#endif

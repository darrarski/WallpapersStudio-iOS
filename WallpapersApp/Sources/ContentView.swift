import SwiftUI

struct ContentView: View {
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
                x: imageFrame.center.x - imageFrame.width / 2,
                y: imageFrame.center.y - imageFrame.height / 2
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
            .applying(.scaledBy(delta))
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
              exportAction: self.exportImage
            )
            .transition(
              AnyTransition
                .move(edge: .bottom)
                .combined(with: .offset(y: geometry.safeAreaInsets.bottom))
            )
          }
        }
      }
    }
    .navigationBarHidden(true)
    .sheet(isPresented: $isPresentingImagePicker) {
      ImagePicker(onImport: self.loadImage(_:))
    }
  }

  private func loadImage(_ image: UIImage) {
    self.image = image
    self.imageFrame = CGRect(
      origin: .zero,
      size: image.size
    )
  }

  private func exportImage() {
    // TODO: implement cropping based on image frame

    // guard let image = self.image else { return }
    //
    // let croppingRect = image.croppingRect(
    //   size: geometry.sizeIgnoringSafeArea.applying(.scaledBy(1.2)),
    //   offset: self.imageOffset,
    //   scale: self.imageScale
    // )
    //
    // let exportedImage = image
    //   .cropped(to: croppingRect)
    // // TODO: resize image maintaining aspect ratio
    //
    // if let image = exportedImage {
    //   // TODO: save to photo library
    //   // UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    //   self.loadImage(image)
    // }
  }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
#endif

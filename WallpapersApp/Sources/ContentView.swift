import SwiftUI

struct ContentView: View {
  @State var isPresentingImagePicker = false
  @State var hideToolbars: Bool = false
  @State var image: UIImage?
  @State var imageOffset: CGPoint = .zero
  @State var imageScale: CGFloat = 1.0

  var body: some View {
    NavigationView {
      ZStack {
          if let image = image {
            Image(uiImage: image)
              .scaleEffect(imageScale)
              .frame(
                width: image.size.width * image.scale * imageScale,
                height: image.size.height * image.scale * imageScale
              )
              .offset(x: imageOffset.x, y: imageOffset.y)
          } else {
            Text("No image loaded")
          }
      }
      .onDrag(updateOffset: $imageOffset)
      .onMagnify(updateScale: $imageScale)
      .onTapGesture {
        self.hideToolbars.toggle()
      }
      .navigationTitle("Wallpaper")
      .navigationBarTitleDisplayMode(.inline)
      .navigationBarHidden(hideToolbars)
      .toolbar {
        ToolbarItem(placement: .bottomBar) {
          if !hideToolbars {
            Button(action: { self.isPresentingImagePicker = true }) {
              Image(systemName: "square.and.arrow.down")
            }
          }
        }
      }
      .sheet(isPresented: $isPresentingImagePicker) {
        ImagePicker(image: $image)
      }
    }
  }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
#endif

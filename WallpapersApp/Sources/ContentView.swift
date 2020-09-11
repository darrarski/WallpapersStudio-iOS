import SwiftUI

struct ContentView: View {
  @State var isPresentingImagePicker = false
  @State var hideToolbars: Bool = false

  @State var image: UIImage?

  @State var imageScale: CGFloat = 1.0
  @State var lastScaleValue: CGFloat = 1.0

  @State var imageOffset: CGPoint = .zero
  @State var lastOffsetValue: CGPoint = .zero

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
      .gesture(
        DragGesture()
          .onChanged { value in
            let offset = CGPoint(
              x: value.location.x - value.startLocation.x,
              y: value.location.y - value.startLocation.y
            )
            let delta = CGPoint(
              x: offset.x - self.lastOffsetValue.x,
              y: offset.y - self.lastOffsetValue.y
            )
            self.lastOffsetValue = offset
            self.imageOffset.x += delta.x
            self.imageOffset.y += delta.y
          }
          .onEnded { value in
            self.lastOffsetValue = .zero
          }
      )
      .simultaneousGesture(
        MagnificationGesture()
          .onChanged { value in
            let delta = value / self.lastScaleValue
            self.lastScaleValue = value
            self.imageScale *= delta
          }
          .onEnded { _ in
            self.lastScaleValue = 1.0
          },
        including: .all
      )
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

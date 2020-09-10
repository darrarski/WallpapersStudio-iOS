import SwiftUI

struct ContentView: View {
  @State var isPresentingImagePicker = false
  @State var image: UIImage?
  @State var imageScale: CGFloat = 1.0
  @State var lastScaleValue: CGFloat = 1.0
  @State var hideToolbars: Bool = false

  var body: some View {
    NavigationView {
      ScrollView([.horizontal, .vertical], showsIndicators: false) {
        ScrollViewReader { proxy in
          if let image = image {
            Image(uiImage: image)
              .scaleEffect(imageScale)
              .frame(
                width: image.size.width * image.scale * imageScale,
                height: image.size.height * image.scale * imageScale
              )
              .id(0)
              .onAppear {
                proxy.scrollTo(0, anchor: .center)
              }
          } else {
            Text("No image loaded")
          }
        }
      }
      .edgesIgnoringSafeArea(.all)
      .onTapGesture {
        self.hideToolbars.toggle()
      }
      .gesture(
        MagnificationGesture()
          .onChanged { value in
            let delta = value / self.lastScaleValue
            self.lastScaleValue = value
            self.imageScale *= delta
          }
          .onEnded { _ in
            self.lastScaleValue = 1.0
          }
      )
      .navigationTitle("Wallpaper")
      .navigationBarTitleDisplayMode(.inline)
      .navigationBarHidden(hideToolbars)
      .toolbar {
        ToolbarItem(placement: .bottomBar) {
          if !hideToolbars {
            Button(action: { self.isPresentingImagePicker = true }) {
              Image(systemName: "photo.on.rectangle")
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

import SwiftUI

struct ContentView: View {
  var body: some View {
    Text("Hello, world!")
      .padding()
  }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
#endif

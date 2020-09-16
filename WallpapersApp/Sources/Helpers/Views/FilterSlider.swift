import SwiftUI

struct FilterSlider<V>: View where V: BinaryFloatingPoint, V.Stride: BinaryFloatingPoint {
  var icon: String
  var title: String
  var valueString: String
  var value: Binding<V>
  var range: ClosedRange<V>

  var body: some View {
    VStack {
      HStack(alignment: .firstTextBaseline) {
        Image(systemName: icon)
          .foregroundColor(.accentColor)
        Text(title)
        Spacer()
        Text(valueString)
      }
      Slider(value: value, in: range)
    }
    .padding(.bottom)
  }
}

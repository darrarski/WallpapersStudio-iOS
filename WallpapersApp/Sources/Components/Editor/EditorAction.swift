import struct CoreGraphics.CGSize
import class UIKit.UIImage

enum EditorAction: Equatable {
  case presentImagePicker(Bool)
  case toggleMenu
  case loadImage(UIImage)
  case exportImage
  case didExportImage
  case didFailExportingImage
  case dismissAlert
  case applyFilters
  case didApplyFilters(UIImage)
  case canvas(CanvasAction)
  case menu(MenuAction)
}

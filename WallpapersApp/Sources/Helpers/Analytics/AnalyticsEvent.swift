import struct CoreGraphics.CGFloat
import struct CoreGraphics.CGSize
import struct CoreGraphics.CGPoint
import struct CoreGraphics.CGRect

struct AnalyticsEvent: Equatable {
  var name: String
  var payload: [String: String] = [:]
}

extension AnalyticsEvent {
  static var appStart: AnalyticsEvent {
    AnalyticsEvent(name: "appStart")
  }
}

extension AnalyticsEvent {
  static func toggleMenu(_ present: Bool) -> AnalyticsEvent {
    AnalyticsEvent(name: "toggleMenu", payload: ["presented": format(present)])
  }
}

extension AnalyticsEvent {
  static var importFromLibrary: AnalyticsEvent {
    AnalyticsEvent(name: "importFromLibrary")
  }
}

extension AnalyticsEvent {
  static func loadImage(size: CGSize, scale: CGFloat) -> AnalyticsEvent {
    AnalyticsEvent(name: "loadImage", payload: [
      "size": format(size),
      "scale": format(scale)
    ])
  }
}

extension AnalyticsEvent {
  static var exportToLibrary: AnalyticsEvent {
    AnalyticsEvent(name: "exportToLibrary")
  }
}

extension AnalyticsEvent {
  static func exportImage(
    size: CGSize,
    frame: CGRect,
    blur: CGFloat,
    saturation: CGFloat,
    hue: CGFloat
  ) -> AnalyticsEvent {
    AnalyticsEvent(name: "exportImage", payload: [
      "size": format(size),
      "frame": format(frame),
      "blur": format(blur),
      "saturation": format(saturation),
      "hue": format(hue)
    ])
  }
}

extension AnalyticsEvent {
  static var didExportImage: AnalyticsEvent {
    AnalyticsEvent(name: "didExportImage")
  }
}

extension AnalyticsEvent {
  static var didFailExportingImage: AnalyticsEvent {
    AnalyticsEvent(name: "didFailExportingImage")
  }
}

private func format(_ bool: Bool) -> String {
  bool ? "true" : "false"
}

private func format(_ float: CGFloat) -> String {
  String(format: "%0.f", float)
}

private func format(_ size: CGSize) -> String {
  "W:\(format(size.width)) H:\(format(size.height))"
}

private func format(_ point: CGPoint) -> String {
  "X:\(format(point.x)) Y:\(format(point.y))"
}

private func format(_ rect: CGRect) -> String {
  "\(format(rect.origin)) \(format(rect.size))"
}

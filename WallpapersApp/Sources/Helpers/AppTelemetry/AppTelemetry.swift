import TelemetryClient
import struct CoreGraphics.CGFloat
import struct CoreGraphics.CGSize
import struct CoreGraphics.CGPoint
import struct CoreGraphics.CGRect

struct AppTelemetry {
  static var defaultInitializer: (TelemetryManagerConfiguration) -> Void = TelemetryManager.initialize(with:)
  static var defaultSend: (Signal) -> Void = TelemetryManager.send

  var initialize: (TelemetryManagerConfiguration) -> Void = Self.defaultInitializer
  var send: (Signal) -> Void = Self.defaultSend
}

extension AppTelemetry {
  struct Signal: Equatable {
    var name: String
    var payload: [String: String] = [:]

    static var appStart: Signal {
      Signal(name: "appStart")
    }

    static func toggleMenu(_ present: Bool) -> Signal {
      Signal(name: "toggleMenu", payload: ["presented": format(present)])
    }

    static var importFromLibrary: Signal {
      Signal(name: "importFromLibrary")
    }

    static func loadImage(size: CGSize, scale: CGFloat) -> Signal {
      Signal(name: "loadImage", payload: [
        "size": format(size),
        "scale": format(scale)
      ])
    }

    static var exportToLibrary: Signal {
      Signal(name: "exportToLibrary")
    }

    static func exportImage(
      size: CGSize,
      frame: CGRect,
      blur: CGFloat,
      saturation: CGFloat,
      hue: CGFloat
    ) -> Signal {
      Signal(name: "exportImage", payload: [
        "size": format(size),
        "frame": format(frame),
        "blur": format(blur),
        "saturation": format(saturation),
        "hue": format(hue)
      ])
    }
  }
}

private extension TelemetryManager {
  static func send(_ signal: AppTelemetry.Signal) {
    send(signal.name, with: signal.payload)
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

#if os(macOS)
import AppKit
import SwiftUI

final class WindowController: NSObject, ObservableObject {
  deinit {
    close()
  }

  var window: NSWindow?

  func present<Content>(
    title: String,
    styleMask: NSWindow.StyleMask,
    @ViewBuilder content: @escaping () -> Content
  ) where Content: View {
    if let window = window as? Window<Content> {
      window.update(with: content())
      window.makeKeyAndOrderFront(nil)
      return
    }
    close()
    window = Window.create(with: content())
    window?.title = title
    window?.styleMask = styleMask
    window?.delegate = self
    window?.makeKeyAndOrderFront(nil)
  }

  func close() {
    window?.orderOut(nil)
    window = nil
  }

  final class Window<Content>: NSWindow where Content: View {
    static func create(with content: Content) -> Self {
      let contentViewController = NSHostingController(rootView: content)
      return .init(contentViewController: contentViewController)
    }

    func update(with content: Content) {
      let contentViewController = self.contentViewController as? NSHostingController<Content>
      contentViewController?.rootView = content
    }
  }
}

extension WindowController: NSWindowDelegate {
  func windowWillClose(_ notification: Notification) {
    window = nil
  }
}
#endif

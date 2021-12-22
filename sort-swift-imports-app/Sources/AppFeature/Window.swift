#if os(macOS)
import SwiftUI
import AppKit

struct Window<Content>: NSViewRepresentable where Content: View {
  var title: String
  var styleMask: NSWindow.StyleMask
  @Binding var isPresented: Bool
  var content: () -> Content

  func makeCoordinator() -> Coordinator {
    let coordinator = Coordinator()
    coordinator.onClose = { isPresented = false }
    return coordinator
  }

  func makeNSView(context: Context) -> NSView {
    if context.coordinator.window == nil {
      let controller = NSHostingController(rootView: content())
      let window = NSWindow(contentViewController: controller)
      window.delegate = context.coordinator
      window.styleMask = styleMask
      window.title = title
      context.coordinator.window = window
    }
    return NSView()
  }

  func updateNSView(_ nsView: NSView, context: Context) {
    let window = context.coordinator.window
    let controller = window?.contentViewController as? NSHostingController<Content>

    window?.title = title
    window?.styleMask = styleMask
    controller?.rootView = content()

    if isPresented == true && window?.isKeyWindow == false {
      window?.makeKeyAndOrderFront(nil)
    } else if isPresented == false && window?.isVisible == true {
      window?.close()
    }
  }

  final class View: NSWindow {

  }

  final class Coordinator: NSObject, NSWindowDelegate {
    var window: NSWindow?
    var onClose: () -> Void = {}

    func windowWillClose(_ notification: Notification) {
      onClose()
    }
  }
}
#endif

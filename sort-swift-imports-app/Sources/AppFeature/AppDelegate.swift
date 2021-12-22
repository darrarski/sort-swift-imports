import AppKit
import SwiftUI

final class AppDelegate: NSObject, NSApplicationDelegate {
  private lazy var helpWindow: NSWindow = createHelpWindow()

  func openHelpWindow() {
    helpWindow.makeKeyAndOrderFront(nil)
  }

  private func createHelpWindow() -> NSWindow {
    let controller = NSHostingController(rootView: HelpView())
    let window = NSWindow(contentViewController: controller)
    window.title = "Sort Swift Imports Help"
    return window
  }
}

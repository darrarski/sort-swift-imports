import AppKit
import SwiftUI

final class AppDelegate: NSObject, NSApplicationDelegate {
  let appInfo = AppInfo(.main)

  func openAboutWindow() {
    aboutWindow.makeKeyAndOrderFront(nil)
  }

  func openHelpWindow() {
    helpWindow.makeKeyAndOrderFront(nil)
  }

  private lazy var aboutWindow: NSWindow = createAboutWindow()
  private lazy var helpWindow: NSWindow = createHelpWindow()

  private func createAboutWindow() -> NSWindow {
    let controller = NSHostingController(rootView: AboutView(appInfo: appInfo))
    let window = NSWindow(contentViewController: controller)
    window.styleMask = [.titled, .closable]
    window.title = "About \(appInfo.name)"
    return window
  }

  private func createHelpWindow() -> NSWindow {
    let controller = NSHostingController(rootView: HelpView())
    let window = NSWindow(contentViewController: controller)
    window.styleMask = [.titled, .closable]
    window.title = "\(appInfo.name) Help"
    return window
  }
}

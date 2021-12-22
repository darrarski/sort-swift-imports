import SwiftUI
#if os(macOS)
import AppKit
#elseif os(iOS)
import UIKit
#endif

final class AppDelegate: NSObject {
  let appInfo = AppInfo(.main)

  #if os(macOS)
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
  #endif
}

#if os(macOS)
extension AppDelegate: NSApplicationDelegate {}
#endif

#if os(iOS)
extension AppDelegate: UIApplicationDelegate {}
#endif

import EditorFeature
import SwiftUI

@main
struct App: SwiftUI.App {
  let appInfo = AppInfo(.main)

  #if os(macOS)
  let aboutWindow = WindowController()
  let helpWindow = WindowController()

  var body: some Scene {
    WindowGroup {
      LazyView {
        AppView(
          appInfo: appInfo,
          openAbout: openAboutWindow,
          openHelp: openHelpWindow
        )
      }
    }
    .commands {
      CommandGroup(replacing: .appInfo) {
        Button(action: openAboutWindow) {
          Text("About \(appInfo.name)")
        }
      }
      CommandGroup(replacing: .help) {
        Button(action: openHelpWindow) {
          Text("\(appInfo.name) Help")
        }
      }
      SidebarCommands()
    }
  }

  func openAboutWindow() {
    aboutWindow.present(
      title: "About \(appInfo.name)",
      styleMask: [.titled, .closable]
    ) {
      AboutView(appInfo: appInfo)
    }
  }

  func openHelpWindow() {
    helpWindow.present(
      title: "\(appInfo.name) Help",
      styleMask: [.titled, .closable],
      content: HelpView.init
    )
  }

  #elseif os(iOS)
  var body: some Scene {
    WindowGroup {
      LazyView {
        AppView(appInfo: appInfo)
      }
    }
  }
  #endif
}

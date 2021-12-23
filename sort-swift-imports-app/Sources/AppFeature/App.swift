import EditorFeature
import SwiftUI

@main
struct App: SwiftUI.App {
  #if os(macOS)
  @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

  var body: some Scene {
    WindowGroup {
      LazyView {
        AppView(
          appInfo: appDelegate.appInfo,
          openAbout: appDelegate.openAboutWindow,
          openHelp: appDelegate.openHelpWindow
        )
      }
    }
    .commands {
      CommandGroup(replacing: .appInfo) {
        Button(action: appDelegate.openAboutWindow) {
          Text("About \(appDelegate.appInfo.name)")
        }
      }
      CommandGroup(replacing: .help) {
        Button(action: appDelegate.openHelpWindow) {
          Text("\(appDelegate.appInfo.name) Help")
        }
      }
      SidebarCommands()
    }
  }
  #elseif os(iOS)
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

  var body: some Scene {
    WindowGroup {
      LazyView {
        AppView(appInfo: appDelegate.appInfo)
      }
    }
  }
  #endif
}

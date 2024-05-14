import AboutFeature
import AcknowledgmentsFeature
import AppShared
import ComposableArchitecture
import EditorFeature
import HelpFeature
import SwiftUI

@main
struct App: SwiftUI.App {
  let appInfo = AppInfo(bundle: .main)
  @Dependency(\.openWindow) var openWindow

  var body: some Scene {
#if os(iOS)
    WindowGroup {
      AppView(
        store: Store(
          initialState: AppReducer.State(
            appInfo: appInfo
          )
        ) {
          AppReducer()
        }
      )
    }
#elseif os(macOS)
    WindowGroup {
      AppView(
        store: Store(
          initialState: AppReducer.State(
            appInfo: appInfo
          )
        ) {
          AppReducer()
        }
      )
    }
    .windowResizability(.contentMinSize)
    .commands {
      CommandGroup(replacing: .appInfo) {
        Button("About \(appInfo.name)") {
          openWindow(id: AppWindowID.about.rawValue)
        }
      }
      CommandGroup(replacing: .help) {
        Button("\(appInfo.name) Help") {
          openWindow(id: AppWindowID.help.rawValue)
        }
      }
    }

    Window(Text("About \(appInfo.name)"), id: AppWindowID.about.rawValue) {
      AboutView(
        store: Store(
          initialState: AboutReducer.State(
            appInfo: appInfo
          )
        ) {
          AboutReducer()
        }
      )
    }
    .windowResizability(.contentMinSize)

    Window(Text("\(appInfo.name) Help"), id: AppWindowID.help.rawValue) {
      HelpView(
        store: Store(
          initialState: HelpReducer.State()
        ) {
          HelpReducer()
        }
      )
    }
    .windowResizability(.contentMinSize)

    Window(Text("Acknowledgments"), id: AppWindowID.acknowledgments.rawValue) {
      AcknowledgmentsView(
        store: Store(
          initialState: AcknowledgmentsReducer.State()
        ) {
          AcknowledgmentsReducer()
        }
      )
    }
    .windowResizability(.contentMinSize)
#endif
  }
}

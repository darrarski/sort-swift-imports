import EditorFeature
import SwiftUI

@main
struct App: SwiftUI.App {
  #if os(macOS)
  @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
  #elseif os(iOS)
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
  #endif

  var body: some Scene {
    WindowGroup {
      #if os(macOS)
      LazyView(content: editorView)
      #elseif os(iOS)
      NavigationView {
        editorView()
          .navigationTitle(appDelegate.appInfo.name)
          .navigationBarTitleDisplayMode(.inline)
      }
      .navigationViewStyle(.stack)
      #endif
    }
    .commands {
      CommandGroup(replacing: .appInfo) {
        Button(action: openAbout) {
          Text("About \(appDelegate.appInfo.name)")
        }
      }
      CommandGroup(replacing: .help) {
        Button(action: openHelp) {
          Text("\(appDelegate.appInfo.name) Help")
        }
      }
    }
  }

  func editorView() -> some View {
    EditorView(store: .init(
      initialState: .init(),
      reducer: editorReducer,
      environment: .init(
        openAbout: openAbout,
        openHelp: openHelp,
        sort: .live,
        sortScheduler: DispatchQueue.global(qos: .userInitiated).eraseToAnyScheduler(),
        mainScheduler: .main
      )
    ))
  }

  func openAbout() {
    #if os(macOS)
    appDelegate.openAboutWindow()
    #elseif os(iOS)
    // TODO:
    #endif
  }

  func openHelp() {
    #if os(macOS)
    appDelegate.openHelpWindow()
    #elseif os(iOS)
    // TODO:
    #endif
  }
}

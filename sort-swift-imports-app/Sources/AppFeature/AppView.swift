import ComposableArchitecture
import EditorFeature
import SwiftUI

struct AppView: View {
  var appInfo: AppInfo
  #if os(macOS)
  var openAbout: () -> Void
  var openHelp: () -> Void
  #elseif os(iOS)
  @State var isPresentingAbout = false
  @State var isPresentingHelp = false
  func openAbout() { isPresentingAbout = true }
  func openHelp() { isPresentingHelp = true }
  #endif

  var body: some View {
    #if os(macOS)
    editorView()
    #elseif os(iOS)
    NavigationView {
      editorView()
        .navigationTitle(appInfo.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    .navigationViewStyle(.stack)
    .sheet(isPresented: $isPresentingAbout) {
      NavigationView {
        ScrollView(.vertical) {
          AboutView(appInfo: appInfo)
        }
        .navigationTitle("About the app")
        .navigationBarTitleDisplayMode(.inline)
      }
      .navigationViewStyle(.stack)
    }
    .sheet(isPresented: $isPresentingHelp) {
      NavigationView {
        ScrollView(.vertical) {
          HelpView()
        }
        .navigationTitle("Help")
        .navigationBarTitleDisplayMode(.inline)
      }
      .navigationViewStyle(.stack)
    }
    #endif
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
}

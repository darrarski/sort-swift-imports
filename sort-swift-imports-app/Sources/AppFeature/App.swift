import EditorFeature
import SwiftUI

@main
struct App: SwiftUI.App {
  @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

  var body: some Scene {
    WindowGroup {
      LazyView {
        EditorView(store: .init(
          initialState: .init(),
          reducer: editorReducer,
          environment: .init(
            sort: .live,
            sortScheduler: DispatchQueue.global(qos: .userInitiated).eraseToAnyScheduler(),
            mainScheduler: .main
          )
        ))
      }
    }
  }
}

import AppFeature
import ComposableArchitecture
import SortSwiftImports
import SwiftUI

@main
struct App: SwiftUI.App {
  var body: some Scene {
    WindowGroup {
      AppView(store: .init(
        initialState: .init(),
        reducer: appReducer,
        environment: .init(
          sort: .live,
          sortScheduler: DispatchQueue.global(qos: .userInitiated).eraseToAnyScheduler(),
          mainScheduler: .main
        )
      ))
    }
  }
}

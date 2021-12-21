import AppFeature
import ComposableArchitecture
import SwiftUI

@main
struct App: SwiftUI.App {
  var body: some Scene {
    WindowGroup {
      AppView(store: .init(
        initialState: .init(),
        reducer: appReducer,
        environment: .init()
      ))
    }
  }
}

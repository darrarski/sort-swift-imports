import AboutFeature
import AppShared
import ComposableArchitecture
import EditorFeature
import HelpFeature
import SwiftUI

struct AppView: View {
  @State var store: StoreOf<AppReducer>

  var body: some View {
    NavigationStack {
      EditorView(
        store: store.scope(
          state: \.editor,
          action: \.editor
        )
      )
    }
#if os(iOS)
    .sheet(
      item: $store.scope(
        state: \.destination?.about,
        action: \.destination.about
      ),
      content: { store in
        NavigationStack {
          ScrollView {
            AboutView(store: store)
          }
          .navigationTitle("About the app")
          .navigationBarTitleDisplayMode(.inline)
        }
      }
    )
    .sheet(
      item: $store.scope(
        state: \.destination?.help,
        action: \.destination.help
      ),
      content: { store in
        NavigationStack {
          ScrollView {
            HelpView(store: store)
          }
          .navigationTitle("Help")
          .navigationBarTitleDisplayMode(.inline)
        }
      }
    )
#endif
  }
}

#Preview {
  AppView(
    store: Store(
      initialState: AppReducer.State()
    ) {
      AppReducer()
        ._printChanges()
    }
  )
}

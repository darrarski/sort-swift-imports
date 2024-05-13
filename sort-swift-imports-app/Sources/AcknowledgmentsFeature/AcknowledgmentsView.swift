import AppShared
import ComposableArchitecture
import SwiftUI

public struct AcknowledgmentsView: View {
  public init(store: StoreOf<AcknowledgmentsReducer>) {
    self.store = store
  }
  
  public let store: StoreOf<AcknowledgmentsReducer>

  public var body: some View {
    NavigationSplitView {
      List {
        ForEach(store.acknowledgments) { acknowledgment in
          NavigationLink(value: acknowledgment) {
            Text(acknowledgment.title)
              .multilineTextAlignment(.leading)
#if os(macOS)
              .fixedSize(horizontal: true, vertical: false)
#endif
          }
        }
      }
      .navigationTitle("Acknowledgments")
#if os(iOS)
      .navigationBarTitleDisplayMode(.inline)
#endif
      .navigationDestination(for: Acknowledgment.self) { acknowledgment in
        ScrollView {
          Text(acknowledgment.text)
            .multilineTextAlignment(.leading)
            .padding()
        }
        .navigationTitle(acknowledgment.title)
#if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
#endif
      }
    } detail: {
      Image(systemName: "app.dashed")
    }
#if os(macOS)
    .frame(minWidth: 800, minHeight: 600)
#endif
  }
}

#Preview {
  AcknowledgmentsView(
    store: Store(
      initialState: AcknowledgmentsReducer.State()
    ) {
      AcknowledgmentsReducer()
        ._printChanges()
    }
  )
}

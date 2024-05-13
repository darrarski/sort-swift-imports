import AcknowledgmentsFeature
import AppIcon
import AppShared
import ComposableArchitecture
import SwiftUI

@ViewAction(for: AboutReducer.self)
public struct AboutView: View {
  public init(store: StoreOf<AboutReducer>) {
    self.store = store
  }

  @Bindable public var store: StoreOf<AboutReducer>

  public var body: some View {
    VStack {
      AppIconView(.macOS)
        .frame(width: 128, height: 128)
        .shadow(color: .black, radius: 1, x: 1, y: 1)

      Text(store.appInfo.name)
        .font(.title)
        .padding(.bottom)

      Text("Version \(store.appInfo.version) build \(store.appInfo.build)")
        .padding(.bottom)

      Text(store.appInfo.copyright)
        .padding(.bottom)

      Link(destination: URL(string: "https://sort-swift-imports.darrarski.pl")!) {
        Label("\(store.appInfo.name) Website", systemImage: "link")
#if os(iOS)
          .padding()
#endif
      }

      Link(destination: URL(string: "https://darrarski.pl")!) {
        Label("Dariusz Rybicki Darrarski", systemImage: "link")
#if os(iOS)
          .padding()
#endif
      }
      .padding(.bottom)

      Button("Acknowledgments") {
        send(.acknowledgmentsTapped)
      }
#if os(iOS)
      .buttonStyle(.borderedProminent)
#endif
    }
    .multilineTextAlignment(.center)
#if os(macOS)
    .fixedSize(horizontal: true, vertical: false)
#endif
    .padding()
    .padding()
#if os(iOS)
    .sheet(
      item: $store.scope(
        state: \.destination?.acknowledgments,
        action: \.destination.acknowledgments
      ),
      content: { store in
        AcknowledgmentsView(store: store)
      }
    )
#endif
  }
}

#Preview {
  AboutView(
    store: Store(
      initialState: AboutReducer.State(
        appInfo: .stub
      )
    ) {
      AboutReducer()
        ._printChanges()
    }
  )
}

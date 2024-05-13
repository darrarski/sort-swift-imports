import AcknowledgmentsFeature
import AppShared
import ComposableArchitecture
import XCTest
@testable import AboutFeature

final class AboutReducerTests: XCTestCase {
#if os(iOS)
  @MainActor
  func testOpenAcknowledgments() async {
    let store = TestStore(
      initialState: AboutReducer.State(
        appInfo: .stub
      )
    ) {
      AboutReducer()
    }

    await store.send(.view(.acknowledgmentsTapped)) {
      $0.destination = .acknowledgments(AcknowledgmentsReducer.State())
    }
    await store.send(.destination(.dismiss)) {
      $0.destination = nil
    }
  }
#elseif os(macOS)
  @MainActor
  func testOpenAcknowledgments() async {
    let didOpenWindow = LockIsolated<[String]>([])
    let store = TestStore(
      initialState: AboutReducer.State(
        appInfo: .stub
      )
    ) {
      AboutReducer()
    } withDependencies: {
      $0.openWindow.open = { @Sendable id in
        didOpenWindow.withValue { $0.append(id) }
      }
    }

    await store.send(.view(.acknowledgmentsTapped))
    XCTAssertNoDifference(didOpenWindow.value, [AppWindowID.acknowledgments.rawValue])
  }
#endif
}

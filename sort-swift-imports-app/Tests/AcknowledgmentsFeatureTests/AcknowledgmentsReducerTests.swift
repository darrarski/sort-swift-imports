import AppShared
import ComposableArchitecture
import XCTest
@testable import AcknowledgmentsFeature

final class AcknowledgmentsReducerTests: XCTestCase {
  @MainActor
  func testExample() async {
    let store = TestStore(
      initialState: AcknowledgmentsReducer.State()
    ) {
      AcknowledgmentsReducer()
    }

    await store.finish()
  }
}

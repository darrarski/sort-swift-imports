import AppShared
import ComposableArchitecture
import XCTest
@testable import HelpFeature

final class HelpReducerTests: XCTestCase {
  @MainActor
  func testExample() async {
    let store = TestStore(
      initialState: HelpReducer.State()
    ) {
      HelpReducer()
    }

    await store.finish()
  }
}

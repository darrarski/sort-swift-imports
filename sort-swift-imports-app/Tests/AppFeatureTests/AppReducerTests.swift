import AboutFeature
import AppShared
import ComposableArchitecture
import HelpFeature
import XCTest
@testable import AppFeature

final class AppReducerTests: XCTestCase {
#if os(iOS)
  @MainActor
  func testEditorOpenAbout() async {
    let store = TestStore(
      initialState: AppReducer.State()
    ) {
      AppReducer()
    }

    await store.send(.editor(.delegate(.openAbout))) {
      $0.destination = .about(AboutReducer.State())
    }
    await store.send(.destination(.dismiss)) {
      $0.destination = nil
    }
  }
#elseif os(macOS)
  @MainActor
  func testEditorOpenAbout() async {
    let didOpenWindow = LockIsolated<[String]>([])
    let store = TestStore(
      initialState: AppReducer.State()
    ) {
      AppReducer()
    } withDependencies: {
      $0.openWindow.open = { @Sendable id in
        didOpenWindow.withValue { $0.append(id) }
      }
    }

    await store.send(.editor(.delegate(.openAbout)))
    XCTAssertNoDifference(didOpenWindow.value, [AppWindowID.about.rawValue])
  }
#endif

#if os(iOS)
  @MainActor
  func testEditorOpenHelp() async {
    let store = TestStore(
      initialState: AppReducer.State()
    ) {
      AppReducer()
    }

    await store.send(.editor(.delegate(.openHelp))) {
      $0.destination = .help(HelpReducer.State())
    }
    await store.send(.destination(.dismiss)) {
      $0.destination = nil
    }
  }
#elseif os(macOS)
  @MainActor
  func testEditorOpenHelp() async {
    let didOpenWindow = LockIsolated<[String]>([])
    let store = TestStore(
      initialState: AppReducer.State()
    ) {
      AppReducer()
    } withDependencies: {
      $0.openWindow.open = { @Sendable id in
        didOpenWindow.withValue { $0.append(id) }
      }
    }

    await store.send(.editor(.delegate(.openHelp)))
    XCTAssertNoDifference(didOpenWindow.value, [AppWindowID.help.rawValue])
  }
#endif
}

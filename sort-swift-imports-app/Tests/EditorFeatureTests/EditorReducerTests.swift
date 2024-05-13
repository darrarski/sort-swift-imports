import ComposableArchitecture
import XCTest
@testable import EditorFeature

final class EditorReducerTests: XCTestCase {
  @MainActor
  func testEditContent() async {
    let store = TestStore(
      initialState: EditorReducer.State()
    ) {
      EditorReducer()
    }

    await store.send(.set(\.content, "New Content")) {
      $0.content = "New Content"
    }
  }

  @MainActor
  func testSortImports() async {
    let didSortImports = LockIsolated<[String]>([])
    let sortImportsOutput = "sortImportsOutput"
    let store = TestStore(
      initialState: EditorReducer.State()
    ) {
      EditorReducer()
    } withDependencies: {
      $0[EditorEnvironment.self].sortImports = { @Sendable input in
        didSortImports.withValue { $0.append(input) }
        return sortImportsOutput
      }
    }

    await store.send(.view(.sortImportsTapped)) {
      $0.isSorting = true
    }
    await store.receive(\.didSort.success) {
      $0.isSorting = false
      $0.content = sortImportsOutput
    }
  }

  @MainActor
  func testSortImportsWhenSorting() async {
    let store = TestStore(
      initialState: EditorReducer.State(
        isSorting: true
      )
    ) {
      EditorReducer()
    }

    await store.send(.view(.sortImportsTapped))
  }

  @MainActor
  func testSortImportsFailure() async {
    struct Failure: LocalizedError {
      let errorDescription: String = "Failure Mock"
    }
    let failure = Failure()
    let store = TestStore(
      initialState: EditorReducer.State()
    ) {
      EditorReducer()
    } withDependencies: {
      $0[EditorEnvironment.self].sortImports = { @Sendable _ in
        throw failure
      }
    }

    await store.send(.view(.sortImportsTapped)) {
      $0.isSorting = true
    }
    await store.receive(\.didSort.failure) {
      $0.isSorting = false
      $0.alert = AlertState(
        title: TextState("Error"),
        message: TextState(failure.localizedDescription)
      )
    }
    await store.send(.alert(.dismiss)) {
      $0.alert = nil
    }
  }

  @MainActor
  func testOpenAbout() async {
    let didOpenAbout = LockIsolated(0)
    let store = TestStore(
      initialState: EditorReducer.State()
    ) {
      EditorReducer()
    } withDependencies: {
      $0[EditorEnvironment.self].openAbout = { @Sendable in
        didOpenAbout.withValue { $0 += 1 }
      }
    }

    await store.send(.view(.aboutTapped))
    XCTAssertEqual(didOpenAbout.value, 1)
  }

  @MainActor
  func testOpenHelp() async {
    let didOpenHelp = LockIsolated(0)
    let store = TestStore(
      initialState: EditorReducer.State()
    ) {
      EditorReducer()
    } withDependencies: {
      $0[EditorEnvironment.self].openHelp = { @Sendable in
        didOpenHelp.withValue { $0 += 1 }
      }
    }

    await store.send(.view(.helpTapped))
    XCTAssertEqual(didOpenHelp.value, 1)
  }
}

import ComposableArchitecture
import SortSwiftImports
import XCTest
@testable import EditorFeature

final class EditorFeatureTests: XCTestCase {
  func testOpenHelp() {
    var didOpenHelp = 0

    var environment = EditorEnvironment.failing
    environment.openHelp = { didOpenHelp += 1 }

    let store = TestStore(
      initialState: .init(),
      reducer: editorReducer,
      environment: environment
    )

    store.send(.openHelp)

    XCTAssertEqual(didOpenHelp, 1)
  }

  func testSorting() {
    let input = "input"
    let output = "output"
    let sortScheduler = DispatchQueue.test
    let mainScheduler = DispatchQueue.test

    var didSort = [String]()

    var environment = EditorEnvironment.failing
    environment.sortScheduler = sortScheduler.eraseToAnyScheduler()
    environment.mainScheduler = mainScheduler.eraseToAnyScheduler()
    environment.sort = .init { text in
      didSort.append(text)
      return .success(output)
    }

    let store = TestStore(
      initialState: .init(content: input),
      reducer: editorReducer,
      environment: environment
    )

    store.send(.sort) {
      $0.isSorting = true
    }

    store.send(.sort)

    XCTAssert(didSort.isEmpty)

    sortScheduler.advance()

    XCTAssertEqual(didSort, [input])

    mainScheduler.advance()

    store.receive(.didSort(.success(output))) {
      $0.isSorting = false
      $0.content = output
    }
  }

  func testSortingFailure() {
    let error = SortSwiftImports.Error.noImportsFound

    var environment = EditorEnvironment.failing
    environment.sortScheduler = .immediate
    environment.mainScheduler = .immediate
    environment.sort = .init { _ in .failure(error) }

    let store = TestStore(
      initialState: .init(),
      reducer: editorReducer,
      environment: environment
    )

    store.send(.sort) {
      $0.isSorting = true
    }

    store.receive(.didSort(.failure(error))) {
      $0.isSorting = false
      $0.alert = .init(
        title: .init("Error"),
        message: .init(error.localizedDescription)
      )
    }

    store.send(.dismissAlert) {
      $0.alert = nil
    }
  }
}

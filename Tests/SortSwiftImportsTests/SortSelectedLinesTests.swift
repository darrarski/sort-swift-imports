import XCTest
@testable import SortSwiftImports

final class SortSelectedLinesTests: XCTestCase {
  func testSorting() {
    let sortSelectedLines = SortSelectedLines.live

    let input = """
    4
    C
    D
    a
    3
    b
    c

    B
    1
    2
    d
    A
    """

    let selections: [SortSelectedLines.TextRange] = [
      .init(
        start: .init(line: 0, column: .random(in: 0...10)),
        end: .init(line: 6, column: .random(in: 0...10))
      ),
      .init(
        start: .init(line: 8, column: .random(in: 0...10)),
        end: .init(line: 12, column: 0)
      ),
    ]

    let expected = """
    3
    4
    C
    D
    a
    b
    c

    1
    2
    B
    d
    A
    """

    let result = sortSelectedLines(in: input, selections: selections)

    switch result {
    case let .success(output):
      XCTAssertEqual(output, expected)
    case let .failure(error):
      XCTFail("Unexpected error: \(error)")
    }
  }

  func testSortingWithoutSelection() {
    let sortSelectedLines = SortSelectedLines.live

    let input = """
    Test
    Abc

    1234
    """

    let result = sortSelectedLines(in: input, selections: [])

    switch result {
    case let .failure(error):
      XCTAssertEqual(error, SortSelectedLines.Error.noSelection)
    case .success:
      XCTFail("Should fail with .noSelection error.")
    }
  }
}

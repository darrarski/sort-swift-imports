import XCTest
@testable import SortSwiftImports

final class SortSwiftImportsTests: XCTestCase {
  func testSorting() {
    let sortSwiftImports = SortSwiftImports.live

    let input = """
    // Demo.swift

    import Foundation
    import CoreData

    import UIKit
    import SwiftUI

    sturct Demo {}

    @testable import MyLibrary
    @testable import MyOtherLibrary

    enum Abc {}
    """

    let expected = """
    // Demo.swift

    import CoreData
    import Foundation
    import SwiftUI
    import UIKit
    @testable import MyLibrary
    @testable import MyOtherLibrary


    sturct Demo {}


    enum Abc {}
    """

    let result = sortSwiftImports(in: input)

    switch result {
    case let .success(output):
      XCTAssertEqual(output, expected)
    case let .failure(error):
      XCTFail("Unexpected error: \(error)")
    }
  }

  func testSortingWithoutImports() {
    let sortSwiftImports = SortSwiftImports.live

    let input = """
    Test
    Abc

    1234
    """

    switch sortSwiftImports(in: input) {
    case let .failure(error):
      XCTAssertEqual(error, SortSwiftImports.Error.noImportsFound)
    case .success:
      XCTFail("Should fail with .noImportsFound error.")
    }
  }
}

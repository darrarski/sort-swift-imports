import Foundation

public struct SortSwiftImports {
  public enum Error: Swift.Error, Equatable, LocalizedError {
    case noImportsFound

    public var errorDescription: String? {
      switch self {
      case .noImportsFound:
        return "No imports were found in the current file."
      }
    }
  }

  public init(run: @escaping (String) -> Result<String, Error>) {
    self.run = run
  }

  var run: (String) -> Result<String, Error>

  public func callAsFunction(in input: String) -> Result<String, Error> {
    run(input)
  }
}

extension SortSwiftImports {
  public static let live = Self { input in
    var lines = input.components(separatedBy: .newlines)

    struct Import {
      var lineNumber: Int
      var line: String
    }

    var imports = [Import]()
    var testableImports = [Import]()

    lines.enumerated().forEach { index, line in
      if line.starts(with: "import ") {
        imports.append(.init(lineNumber: index, line: line))
      } else if line.starts(with: "@testable import ") {
        testableImports.append(.init(lineNumber: index, line: line))
      }
    }

    guard !imports.isEmpty || !testableImports.isEmpty else {
      return .failure(.noImportsFound)
    }

    imports.sort { $0.line < $1.line }
    testableImports.sort { $0.line < $1.line }
    let allImports = imports + testableImports

    allImports.map(\.lineNumber).sorted().reversed().forEach { lineNumber in
      lines.remove(at: lineNumber)
    }

    lines.insert(
      contentsOf: allImports.map(\.line),
      at: allImports.map(\.lineNumber).min()!
    )

    let output = lines.joined(separator: "\n")

    return .success(output)
  }
}

#if DEBUG
extension SortSwiftImports {
  public static let failing = Self { _ in fatalError() }
}
#endif

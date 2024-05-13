import Foundation

public struct SortSelectedLines: Sendable {
  public struct TextRange: Equatable {
    public struct Position: Equatable {
      public init(line: Int, column: Int) {
        self.line = line
        self.column = column
      }

      public var line: Int
      public var column: Int
    }

    public init(start: Position, end: Position) {
      self.start = start
      self.end = end
    }

    public var start: Position
    public var end: Position
  }

  public enum Error: Swift.Error, LocalizedError {
    case noSelection

    public var errorDescription: String? {
      switch self {
      case .noSelection:
        return "No lines selected in the current file."
      }
    }
  }

  public init(run: @escaping @Sendable (String, [TextRange]) -> Result<String, Error>) {
    self.run = run
  }

  var run: @Sendable (String, [TextRange]) -> Result<String, Error>

  public func callAsFunction(in input: String, selections: [TextRange]) -> Result<String, Error> {
    run(input, selections)
  }
}

extension SortSelectedLines {
  public static let live = SortSelectedLines { input, selections in
    var lines = input.components(separatedBy: .newlines)

    let ranges = selections
      .map { range -> (startLine: Int, endLine: Int) in
        let startLine = range.start.line
        var endLine = range.end.line
        if range.end.column == 0 {
          endLine -= 1
        }
        return (startLine, endLine)
      }
      .filter { $0.startLine < $0.endLine }

    guard ranges.isEmpty == false else {
      return .failure(.noSelection)
    }

    ranges.forEach { startLine, endLine in
      let linesRange = startLine...endLine
      let selectedLines = Array(lines[linesRange]).sorted()
      linesRange.enumerated().forEach { selectedLineIndex, lineIndex in
        lines[lineIndex] = selectedLines[selectedLineIndex]
      }
    }

    let output = lines.joined(separator: "\n")
    return .success(output)
  }
}

extension SortSelectedLines {
  public static let failing = Self { _, _ in fatalError() }
}

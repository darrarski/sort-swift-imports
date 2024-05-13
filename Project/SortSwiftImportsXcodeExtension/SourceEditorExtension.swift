import Foundation
import SortSwiftImports
import XcodeKit

final class SourceEditorExtension: NSObject, XCSourceEditorExtension {
  var commandDefinitions: [[XCSourceEditorCommandDefinitionKey: Any]] {
    [
      commandDefinition(
        class: SortSwiftImportsCommand.self,
        title: "Sort swift imports"
      ),
      commandDefinition(
        class: SortSelectedLinesCommand.self,
        title: "Sort selected lines"
      ),
    ]
  }

  func commandDefinition<T: NSObject>(
    class commandClass: T.Type,
    title: String
  ) -> [XCSourceEditorCommandDefinitionKey: Any] {
    let bundleId = Bundle(for: type(of: self)).bundleIdentifier!
    let commandClassName = commandClass.className()
    return [
      .identifierKey: [bundleId, commandClassName].joined(separator: "."),
      .classNameKey: commandClassName,
      .nameKey: title
    ]
  }
}

final class SortSwiftImportsCommand: NSObject, XCSourceEditorCommand {
  func perform(
    with invocation: XCSourceEditorCommandInvocation,
    completionHandler: @escaping ((any Error)?) -> Void
  ) -> Void {
    let sort = SortSwiftImports.live
    let result = sort(in: invocation.buffer.completeBuffer)
    switch result {
    case .success(let output):
      invocation.buffer.completeBuffer = output
      completionHandler(nil)
    case .failure(let error):
      completionHandler(error.asLocalizedNSError())
    }
  }
}

final class SortSelectedLinesCommand: NSObject, XCSourceEditorCommand {
  func perform(
    with invocation: XCSourceEditorCommandInvocation,
    completionHandler: @escaping ((any Error)?) -> Void
  ) {
    let sort = SortSelectedLines.live
    let result = sort(
      in: invocation.buffer.completeBuffer,
      selections: invocation.buffer.selections
        .compactMap { $0 as? XCSourceTextRange }
        .map(SortSelectedLines.TextRange.init)
    )
    switch result {
    case .success(let output):
      invocation.buffer.completeBuffer = output
      completionHandler(nil)
    case .failure(let error):
      completionHandler(error.asLocalizedNSError())
    }
  }
}

extension SortSelectedLines.TextRange {
  init(_ range: XCSourceTextRange) {
    self.init(
      start: .init(range.start),
      end: .init(range.end)
    )
  }
}

extension SortSelectedLines.TextRange.Position {
  init(_ position: XCSourceTextPosition) {
    self.init(
      line: position.line,
      column: position.column
    )
  }
}

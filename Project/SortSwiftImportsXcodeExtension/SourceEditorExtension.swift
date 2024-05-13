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

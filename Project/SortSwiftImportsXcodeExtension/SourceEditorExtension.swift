import Foundation
import SortSwiftImports
import XcodeKit

final class SourceEditorExtension: NSObject, XCSourceEditorExtension {
  var commandDefinitions: [[XCSourceEditorCommandDefinitionKey: Any]] {
    [
      [
        .identifierKey: Bundle(for: type(of: self)).bundleIdentifier! + ".Command",
        .classNameKey: SortSwiftImportsCommand.className(),
        .nameKey: "Sort swift imports in current file"
      ],
    ]
  }

  final class SortSwiftImportsCommand: NSObject, XCSourceEditorCommand {
    func perform(
      with invocation: XCSourceEditorCommandInvocation,
      completionHandler: @escaping ((any Error)?) -> Void
    ) -> Void {
      let sort = SortSwiftImports.live
      switch sort(in: invocation.buffer.completeBuffer) {
      case let .success(output):
        invocation.buffer.completeBuffer = output
        completionHandler(nil)
      case let .failure(error):
        completionHandler(error.asLocalizedNSError())
      }
    }
  }
}

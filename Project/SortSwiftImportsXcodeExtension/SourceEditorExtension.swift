import Foundation
import SortSwiftImports
import XcodeKit

final class SourceEditorExtension: NSObject, XCSourceEditorExtension {
  var commandDefinitions: [[XCSourceEditorCommandDefinitionKey: Any]] {
    [
      [
        .identifierKey: Bundle(for: type(of: self)).bundleIdentifier! + ".Command",
        .classNameKey: Command.className(),
        .nameKey: "Sort swift imports in the current file"
      ],
    ]
  }

  final class Command: NSObject, XCSourceEditorCommand {
    func perform(
      with invocation: XCSourceEditorCommandInvocation,
      completionHandler: @escaping (Error?) -> Void
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

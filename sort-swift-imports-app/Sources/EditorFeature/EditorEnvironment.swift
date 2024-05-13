import Dependencies
import DependenciesMacros

@DependencyClient
public struct EditorEnvironment: Sendable {
  public var openAbout: @Sendable () -> Void
  public var openHelp: @Sendable () -> Void
  public var sortImports: @Sendable (String) throws -> String
}

extension EditorEnvironment: TestDependencyKey {
  public static let testValue = EditorEnvironment()
  public static let previewValue = EditorEnvironment(
    openAbout: { print("^^^ PREVIEW: OPEN ABOUT") },
    openHelp: { print("^^^ PREVIEW: OPEN HELP") },
    sortImports: { input in
      print("^^^ PREVIEW: SORT IMPORTS")
      return input
        .components(separatedBy: .newlines)
        .sorted()
        .joined(separator: "\n")
    }
  )
}

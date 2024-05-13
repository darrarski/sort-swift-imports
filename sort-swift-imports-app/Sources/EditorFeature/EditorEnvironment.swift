import AppShared
import Dependencies
import DependenciesMacros
import SortSwiftImports

@DependencyClient
public struct EditorEnvironment: Sendable {
  public var sortImports: @Sendable (String) throws -> String
}

extension EditorEnvironment: DependencyKey {
  public static let testValue = EditorEnvironment()
  public static let liveValue = EditorEnvironment(
    sortImports: { input in
      try SortSwiftImports.live(in: input).get()
    }
  )
}

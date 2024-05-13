import Dependencies
import DependenciesMacros
import SwiftUI

@DependencyClient
public struct OpenWindowEffect: Sendable {
  public var open: @Sendable (_ id: String) -> Void

  public func callAsFunction(id: String) {
    open(id: id)
  }
}

extension OpenWindowEffect: DependencyKey {
  public static let liveValue = OpenWindowEffect { id in
    Task { @MainActor in
      EnvironmentValues().openWindow(id: id)
    }
  }
}

extension DependencyValues {
  public var openWindow: OpenWindowEffect {
    get { self[OpenWindowEffect.self] }
    set { self[OpenWindowEffect.self] = newValue }
  }
}

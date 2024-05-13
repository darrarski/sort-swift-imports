import AppShared
import ComposableArchitecture

@Reducer
public struct HelpReducer: Sendable {
  @ObservableState
  public struct State: Sendable, Equatable {
    public init() {}
  }

  public enum Action: Sendable {}

  public init() {}

  public var body: some ReducerOf<Self> {
    EmptyReducer()
  }
}

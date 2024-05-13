import AppShared
import ComposableArchitecture

@Reducer
public struct AcknowledgmentsReducer: Sendable {
  @ObservableState
  public struct State: Sendable, Equatable {
    public init(acknowledgments: [Acknowledgment] = .all) {
      self.acknowledgments = acknowledgments
    }
    
    var acknowledgments: [Acknowledgment]
  }

  public enum Action: Sendable {}

  public init() {}

  public var body: some ReducerOf<Self> {
    EmptyReducer()
  }
}

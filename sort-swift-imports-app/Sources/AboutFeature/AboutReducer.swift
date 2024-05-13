import AcknowledgmentsFeature
import AppShared
import ComposableArchitecture
import Foundation

@Reducer
public struct AboutReducer: Sendable {
  @ObservableState
  public struct State: Sendable, Equatable {
    public init(
      appInfo: AppInfo = AppInfo(.main),
      destination: Destination.State? = nil
    ) {
      self.appInfo = appInfo
      self.destination = destination
    }

    var appInfo: AppInfo
    @Presents var destination: Destination.State?
  }

  public enum Action: Sendable, ViewAction {
    case destination(PresentationAction<Destination.Action>)
    case view(View)

    @CasePathable
    public enum View: Sendable {
      case acknowledgmentsTapped
    }
  }

  @Reducer(state: .sendable, .equatable, action: .sendable)
  public enum Destination {
#if os(iOS)
    case acknowledgments(AcknowledgmentsReducer)
#endif
  }

  public init() {}

  @Dependency(\.openWindow) var openWindow

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .destination:
        return .none

      case .view(let action):
        switch action {
        case .acknowledgmentsTapped:
#if os(iOS)
          state.destination = .acknowledgments(AcknowledgmentsReducer.State())
          return .none
#elseif os(macOS)
          return .run { _ in
            openWindow(id: AppWindowID.acknowledgments.rawValue)
          }
#endif
        }
      }
    }
    .ifLet(\.$destination, action: \.destination)
  }
}

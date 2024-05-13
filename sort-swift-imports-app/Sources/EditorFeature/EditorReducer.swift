import AppShared
import ComposableArchitecture

@Reducer
public struct EditorReducer: Sendable {
  @ObservableState
  public struct State: Sendable, Equatable {
    public init(
      content: String = EditorReducer.demoContent,
      isSorting: Bool = false,
      alert: AlertState<Action.Alert>? = nil
    ) {
      self.content = content
      self.isSorting = isSorting
      self.alert = alert
    }

    public var content: String
    public var isSorting: Bool
    @Presents public var alert: AlertState<Action.Alert>?
  }

  public enum Action: Sendable, BindableAction, ViewAction {
    case alert(PresentationAction<Alert>)
    case binding(BindingAction<State>)
    case delegate(Delegate)
    case didSort(Result<String, any Error>)
    case view(View)

    @CasePathable
    public enum Alert: Sendable, Equatable {}

    @CasePathable
    public enum Delegate: Sendable {
      case openAbout
      case openHelp
    }

    @CasePathable
    public enum View: Sendable {
      case aboutTapped
      case helpTapped
      case sortImportsTapped
    }
  }

  public init() {}

  @Dependency(EditorEnvironment.self) var env

  public var body: some ReducerOf<Self> {
    BindingReducer()
    Reduce { state, action in
      switch action {
      case .alert:
        return .none

      case .binding:
        return .none

      case .delegate:
        return .none

      case .didSort(let result):
        state.isSorting = false
        switch result {
        case .success(let text):
          state.content = text
          return .none

        case .failure(let error):
          state.alert = AlertState(
            title: TextState("Error"),
            message: TextState(error.localizedDescription)
          )
          return .none
        }

      case .view(let action):
        switch action {
        case .aboutTapped:
          return .send(.delegate(.openAbout))

        case .helpTapped:
          return .send(.delegate(.openHelp))

        case .sortImportsTapped:
          guard !state.isSorting else { return .none }
          state.isSorting = true
          let input = state.content
          return .run { send in
            let output = try env.sortImports(input)
            await send(.didSort(.success(output)))
          } catch: { error, send in
            await send(.didSort(.failure(error)))
          }
        }
      }
    }
    .ifLet(\.alert, action: \.alert)
  }
}

extension EditorReducer {
  public static let demoContent = """
  import SwiftUI
  import ComposableArchitecture
  import SortSwiftImports

  public struct AppState: Equatable {
      public init(
          text: String = "",
          isSorting: Bool = false,
          alert: AlertState<AppAction>? = nil
      ) {
          self.text = text
          self.isSorting = isSorting
          self.alert = alert
      }

      @BindableState public var text: String
      public var isSorting: Bool
      public var alert: AlertState<AppAction>?
  }

  """
}

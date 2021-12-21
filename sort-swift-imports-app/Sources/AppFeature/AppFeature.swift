import CodeEditor
import ComposableArchitecture
import SortSwiftImports
import SwiftUI

public struct AppState: Equatable {
  public init(
    text: String = Self.demoText,
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

extension AppState {
  public static let demoText = """
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

public enum AppAction: Equatable, BindableAction {
  case sort
  case didSort(Result<String, SortSwiftImports.Error>)
  case binding(BindingAction<AppState>)
  case dismissAlert
}

public struct AppEnvironment {
  public init(
    sort: SortSwiftImports,
    sortScheduler: AnySchedulerOf<DispatchQueue>,
    mainScheduler: AnySchedulerOf<DispatchQueue>
  ) {
    self.sort = sort
    self.sortScheduler = sortScheduler
    self.mainScheduler = mainScheduler
  }

  public var sort: SortSwiftImports
  public var sortScheduler: AnySchedulerOf<DispatchQueue>
  public var mainScheduler: AnySchedulerOf<DispatchQueue>
}

#if DEBUG
extension AppEnvironment {
  public static let failing = Self(
    sort: .failing,
    sortScheduler: .failing,
    mainScheduler: .failing
  )
}
#endif

public let appReducer = Reducer<AppState, AppAction, AppEnvironment>
{ state, action, env in
  switch action {
  case .sort:
    guard state.isSorting == false else {
      return .none
    }
    state.isSorting = true
    return Effect
      .future { [text = state.text] in $0(env.sort(in: text)) }
      .subscribe(on: env.sortScheduler)
      .receive(on: env.mainScheduler)
      .catchToEffect(AppAction.didSort)

  case let .didSort(.success(text)):
    state.isSorting = false
    state.text = text
    return .none

  case let .didSort(.failure(error)):
    state.isSorting = false
    state.alert = .init(
      title: .init("Error"),
      message: .init(error.localizedDescription)
    )
    return .none

  case .dismissAlert:
    state.alert = nil
    return .none

  case .binding(_):
    return .none
  }
}
.binding()

public struct AppView: View {
  public init(store: Store<AppState, AppAction>) {
    self.store = store
  }

  let store: Store<AppState, AppAction>
  @Environment(\.colorScheme) var colorScheme

  struct ViewState: Equatable {
    let text: String
    let isSorting: Bool

    init(state: AppState) {
      text = state.text
      isSorting = state.isSorting
    }
  }

  public var body: some View {
    WithViewStore(store.scope(state: ViewState.init)) { viewStore in
      CodeEditor(
        source: viewStore.binding(
          get: \.text,
          send: { .set(\.$text, $0) }
        ),
        language: .swift,
        theme: {
          switch colorScheme {
          case .light:
            return .atelierSavannaLight
          case .dark:
            return .atelierSavannaDark
          @unknown default:
            return .atelierSavannaLight
          }
        }()
      )
        .disabled(viewStore.isSorting)
        .frame(minWidth: 500, minHeight: 500)
        .toolbar {
          ToolbarItemGroup(placement: .primaryAction) {
            if viewStore.isSorting {
              ProgressView()
                .progressViewStyle(.circular)
                .controlSize(.small)
            }

            Button(action: { viewStore.send(.sort) }) {
              Text("Sort Swift Imports")
            }
            .disabled(viewStore.isSorting)
            .alert(store.scope(state: \.alert), dismiss: .dismissAlert)
          }
        }
    }
  }
}

#if DEBUG
public struct AppView_Previews: PreviewProvider {
  public static var previews: some View {
    AppView(store: .init(
      initialState: .init(),
      reducer: .empty,
      environment: ()
    ))
  }
}
#endif

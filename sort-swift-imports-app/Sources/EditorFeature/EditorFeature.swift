import CodeEditor
import ComposableArchitecture
import SortSwiftImports
import SwiftUI

public struct EditorState: Equatable {
  public init(
    content: String = Self.demoContent,
    isSorting: Bool = false,
    alert: AlertState<EditorAction>? = nil
  ) {
    self.content = content
    self.isSorting = isSorting
    self.alert = alert
  }

  @BindableState public var content: String
  public var isSorting: Bool
  public var alert: AlertState<EditorAction>?
}

extension EditorState {
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

public enum EditorAction: Equatable, BindableAction {
  case openHelp
  case sort
  case didSort(Result<String, SortSwiftImports.Error>)
  case binding(BindingAction<EditorState>)
  case dismissAlert
}

public struct EditorEnvironment {
  public init(
    openHelp: @escaping () -> Void,
    sort: SortSwiftImports,
    sortScheduler: AnySchedulerOf<DispatchQueue>,
    mainScheduler: AnySchedulerOf<DispatchQueue>
  ) {
    self.openHelp = openHelp
    self.sort = sort
    self.sortScheduler = sortScheduler
    self.mainScheduler = mainScheduler
  }

  public var openHelp: () -> Void
  public var sort: SortSwiftImports
  public var sortScheduler: AnySchedulerOf<DispatchQueue>
  public var mainScheduler: AnySchedulerOf<DispatchQueue>
}

#if DEBUG
extension EditorEnvironment {
  public static let failing = Self(
    openHelp: { fatalError() },
    sort: .failing,
    sortScheduler: .failing,
    mainScheduler: .failing
  )
}
#endif

public let editorReducer = Reducer<EditorState, EditorAction, EditorEnvironment>
{ state, action, env in
  switch action {
  case .openHelp:
    return .fireAndForget { env.openHelp() }

  case .sort:
    guard state.isSorting == false else {
      return .none
    }
    state.isSorting = true
    return Effect
      .future { [text = state.content] in $0(env.sort(in: text)) }
      .subscribe(on: env.sortScheduler)
      .receive(on: env.mainScheduler)
      .catchToEffect(EditorAction.didSort)

  case let .didSort(.success(text)):
    state.isSorting = false
    state.content = text
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

public struct EditorView: View {
  public init(store: Store<EditorState, EditorAction>) {
    self.store = store
  }

  let store: Store<EditorState, EditorAction>
  @Environment(\.colorScheme) var colorScheme

  struct ViewState: Equatable {
    let content: String
    let isSorting: Bool

    init(state: EditorState) {
      content = state.content
      isSorting = state.isSorting
    }
  }

  public var body: some View {
    WithViewStore(store.scope(state: ViewState.init)) { viewStore in
      CodeEditor(
        source: viewStore.binding(
          get: \.content,
          send: { .set(\.$content, $0) }
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
              Label("Sort Swift Imports", systemImage: "arrow.up.arrow.down")
                .labelStyle(.titleAndIcon)
            }
            .disabled(viewStore.isSorting)
            .alert(store.scope(state: \.alert), dismiss: .dismissAlert)

            Button(action: { viewStore.send(.openHelp) }) {
              Label("Help", systemImage: "questionmark.circle")
                .labelStyle(.titleAndIcon)
            }
          }
        }
    }
  }
}

#if DEBUG
public struct AppView_Previews: PreviewProvider {
  public static var previews: some View {
    EditorView(store: .init(
      initialState: .init(),
      reducer: .empty,
      environment: ()
    ))
  }
}
#endif
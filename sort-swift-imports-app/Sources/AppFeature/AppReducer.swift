import AboutFeature
import AppShared
import ComposableArchitecture
import EditorFeature
import HelpFeature

@Reducer
struct AppReducer: Sendable {
  @ObservableState
  struct State: Sendable, Equatable {
    init(
      appInfo: AppInfo,
      editor: EditorReducer.State = EditorReducer.State(),
      destination: AppReducer.Destination.State? = nil
    ) {
      self.appInfo = appInfo
      self.editor = editor
      self.destination = destination
    }
    
    var appInfo: AppInfo
    var editor: EditorReducer.State
    @Presents var destination: Destination.State?
  }

  enum Action: Sendable {
    case editor(EditorReducer.Action)
    case destination(PresentationAction<Destination.Action>)
  }

  @Reducer(state: .sendable, .equatable, action: .sendable)
  enum Destination {
#if os(iOS)
    case about(AboutReducer)
    case help(HelpReducer)
#endif
  }

  @Dependency(\.openWindow) var openWindow

  var body: some ReducerOf<Self> {
    Scope(state: \.editor, action: \.editor) {
      EditorReducer()
    }

    Reduce { state, action in
      switch action {
      case .editor(.delegate(let action)):
        switch action {
        case .openAbout:
#if os(iOS)
          state.destination = .about(AboutReducer.State(appInfo: state.appInfo))
          return .none
#elseif os(macOS)
          return .run { _ in
            openWindow(id: AppWindowID.about.rawValue)
          }
#endif

        case .openHelp:
#if os(iOS)
          state.destination = .help(HelpReducer.State())
          return .none
#elseif os(macOS)
          return .run { _ in
            openWindow(id: AppWindowID.help.rawValue)
          }
#endif
        }

      case .editor:
        return .none

      case .destination:
        return .none
      }
    }
    .ifLet(\.$destination, action: \.destination)
  }
}

import ComposableArchitecture
import SortSwiftImports
import SwiftUI

public struct AppState: Equatable {
  public init() {}
}

public enum AppAction: Equatable {}

public struct AppEnvironment {
  public init() {}
}

#if DEBUG
extension AppEnvironment {
  public static let failing = Self()
}
#endif

public let appReducer = Reducer<AppState, AppAction, AppEnvironment>.empty

public struct AppView: View {
  public init(store: Store<AppState, AppAction>) {
    self.store = store
  }

  let store: Store<AppState, AppAction>

  struct ViewState: Equatable {
    init(state: AppState) {}
  }

  public var body: some View {
    WithViewStore(store.scope(state: ViewState.init)) { viewStore in
      Text("AppView")
        .padding()
        .frame(minWidth: 400, minHeight: 300)
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

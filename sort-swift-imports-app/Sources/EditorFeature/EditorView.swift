import AppShared
import CodeEditor
import ComposableArchitecture
import SwiftUI

@ViewAction(for: EditorReducer.self)
public struct EditorView: View {
  public init(store: StoreOf<EditorReducer>) {
    self.store = store
  }

  @State public var store: StoreOf<EditorReducer>
  @Environment(\.colorScheme) var colorScheme

  public var body: some View {
    CodeEditor(
      source: $store.content,
      language: .swift,
      theme: editorTheme
    )
    .disabled(store.isSorting)
#if os(macOS)
    .frame(minWidth: 500, minHeight: 500)
#endif
    .toolbar {
#if os(macOS)
      ToolbarItemGroup(placement: .primaryAction) {
        progressView
        sortButton
        helpButton
      }
#elseif os(iOS)
      ToolbarItemGroup(placement: .navigationBarTrailing) {
        progressView

        Menu {
          sortButton
          aboutButton
          helpButton
        } label: {
          Label("Menu", systemImage: "gearshape")
        }
      }
#endif
    }
    .alert($store.scope(state: \.alert, action: \.alert))
  }

  @MainActor
  var editorTheme: CodeEditor.ThemeName {
    switch colorScheme {
    case .light:
      return .atelierSavannaLight
    case .dark:
      return .atelierSavannaDark
    @unknown default:
      return .atelierSavannaLight
    }
  }

  @MainActor
  @ViewBuilder
  var progressView: some View {
    if store.isSorting {
      ProgressView()
        .progressViewStyle(.circular)
        .controlSize(.small)
    }
  }

  @MainActor
  @ViewBuilder
  var sortButton: some View {
    Button(action: { send(.sortImportsTapped) }) {
      Label("Sort swift imports", systemImage: "arrow.up.arrow.down")
        .labelStyle(.titleAndIcon)
    }
    .disabled(store.isSorting)
  }

  @MainActor
  @ViewBuilder
  var aboutButton: some View {
    Button(action: { send(.aboutTapped) }) {
      Label("About the app", systemImage: "questionmark.circle")
        .labelStyle(.titleAndIcon)
    }
  }

  @MainActor
  @ViewBuilder
  var helpButton: some View {
    Button(action: { send(.helpTapped) }) {
      Label("Help", systemImage: "questionmark.circle")
        .labelStyle(.titleAndIcon)
    }
  }
}

#Preview {
  NavigationStack {
    EditorView(
      store: Store(
        initialState: EditorReducer.State()
      ) {
        EditorReducer()
          ._printChanges()
      }
    )
  }
}

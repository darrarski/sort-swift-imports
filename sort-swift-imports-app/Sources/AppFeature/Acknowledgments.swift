import SwiftUI

struct Acknowledgment: Identifiable, Equatable {
  var id: String
  var title: String
}

extension Sequence where Element == Acknowledgment {
  static var all: [Acknowledgment] {[
    .init(id: "swift-composable-architecture", title: "Swift Composable Architecture"),
    .init(id: "CodeEditor", title: "CodeEditor"),
    .init(id: "swiftui-app-icon-creator", title: "SwiftUI App Icon Creator"),
  ]}
}

extension Acknowledgment {
  var text: String {
    guard let path = Bundle.module.path(forResource: "Acknowledgments-\(id)", ofType: "txt"),
          let content = try? String(contentsOf: URL(fileURLWithPath: path))
    else { return "File not found." }
    return content
  }
}

struct AcknowledgmentsButton: View {
  #if os(macOS)
  @StateObject var acknowledgmentsWindow = WindowController()
  #elseif os(iOS)
  @State var isPresentingAcknowledgments = false
  #endif

  var body: some View {
    Button(action: openAcknowledgments) {
      Text("Acknowledgments")
    }
    #if os(iOS)
    .buttonStyle(.borderedProminent)
    .sheet(isPresented: $isPresentingAcknowledgments, content: content)
    #endif
  }

  func openAcknowledgments() {
    #if os(macOS)
    acknowledgmentsWindow.present(
      title: "Acknowledgments",
      styleMask: [.titled, .closable, .resizable],
      content: content
    )
    #elseif os(iOS)
    isPresentingAcknowledgments = true
    #endif
  }

  func content() -> some View {
    NavigationView {
      List {
        ForEach([Acknowledgment].all) { acknowledgment in
          AcknowledgmentLinkView(acknowledgment: acknowledgment)
        }
      }
      .navigationTitle("Acknowledgments")
      #if os(iOS)
      .navigationBarTitleDisplayMode(.inline)
      #endif
    }
    #if os(iOS)
    .navigationViewStyle(StackNavigationViewStyle())
    #elseif os(macOS)
    .frame(minWidth: 800, minHeight: 600)
    #endif
  }
}

struct AcknowledgmentLinkView: View {
  var acknowledgment: Acknowledgment

  var body: some View {
    NavigationLink {
      ScrollView {
        Text(acknowledgment.text)
          .multilineTextAlignment(.leading)
          .padding()
      }
      .navigationTitle(acknowledgment.title)
      #if os(iOS)
      .navigationBarTitleDisplayMode(.inline)
      #endif
    } label: {
      Text(acknowledgment.title)
        .multilineTextAlignment(.leading)
        #if os(macOS)
        .fixedSize(horizontal: true, vertical: false)
        #endif
    }
  }
}

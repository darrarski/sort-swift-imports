import Foundation

public struct Acknowledgment: Identifiable, Equatable, Hashable, Sendable {
  public init(id: String, title: String) {
    self.id = id
    self.title = title
  }

  public var id: String
  public var title: String
}

extension Acknowledgment {
  public var text: String {
    guard let path = Bundle.module.path(forResource: "Acknowledgments-\(id)", ofType: "txt"),
          let content = try? String(contentsOf: URL(fileURLWithPath: path))
    else {
      return "File not found."
    }
    return content
  }
}

extension Array<Acknowledgment> {
  public static var all: Self {
    [
      Acknowledgment(id: "CodeEditor", title: "CodeEditor"),
      Acknowledgment(id: "sort-swift-imports", title: "Sort Swift Imports"),
      Acknowledgment(id: "swift-composable-architecture", title: "Swift Composable Architecture"),
      Acknowledgment(id: "swiftui-app-icon-creator", title: "SwiftUI App Icon Creator"),
    ]
  }
}

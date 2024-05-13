import AppIcon
import AppIconCreator
import Foundation

extension URL {
  func deletingLastPathComponent() -> URL {
    var url = self
    url.deleteLastPathComponent()
    return url
  }
}

let exportURL = URL(fileURLWithPath: #file)
  .deletingLastPathComponent()
  .deletingLastPathComponent()
  .deletingLastPathComponent()
  .deletingLastPathComponent()
  .appendingPathComponent("Project")
  .appendingPathComponent("SortSwiftImportsApp")
  .appendingPathComponent("Assets.xcassets")
  .appendingPathComponent("AppIcon.appiconset")

[IconImage]
  .images(for: AppIconView(.macOS), with: .macOS)
  .forEach { $0.save(to: exportURL) }

[IconImage]
  .images(for: AppIconView(.iOS), with: [.iOS_App_Store])
  .forEach { $0.save(to: exportURL) }

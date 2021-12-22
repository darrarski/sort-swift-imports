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
  .appendingPathComponent("SortSwiftImportsMacApp")
  .appendingPathComponent("Assets.xcassets")
  .appendingPathComponent("AppIcon.appiconset")

[IconImage]
  .images(for: AppIconView(), with: .macOS)
  .forEach { $0.save(to: exportURL) }

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

let macOSExportURL = URL(fileURLWithPath: #file)
  .deletingLastPathComponent()
  .deletingLastPathComponent()
  .deletingLastPathComponent()
  .deletingLastPathComponent()
  .appendingPathComponent("Project")
  .appendingPathComponent("SortSwiftImportsMacApp")
  .appendingPathComponent("Assets.xcassets")
  .appendingPathComponent("AppIcon.appiconset")

[IconImage]
  .images(for: AppIconView(.macOS), with: .macOS)
  .forEach { $0.save(to: macOSExportURL) }

let iOSExportURL = URL(fileURLWithPath: #file)
  .deletingLastPathComponent()
  .deletingLastPathComponent()
  .deletingLastPathComponent()
  .deletingLastPathComponent()
  .appendingPathComponent("Project")
  .appendingPathComponent("SortSwiftImportsIOSApp")
  .appendingPathComponent("Assets.xcassets")
  .appendingPathComponent("AppIcon.appiconset")

[IconImage]
  .images(for: AppIconView(.iOS), with: .iOS)
  .forEach { $0.save(to: iOSExportURL) }

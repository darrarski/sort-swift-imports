import Foundation

public struct AppInfo: Sendable, Equatable {
  public init(
    name: String,
    version: String,
    build: String,
    copyright: String
  ) {
    self.name = name
    self.version = version
    self.build = build
    self.copyright = copyright
  }
  
  public var name: String
  public var version: String
  public var build: String
  public var copyright: String
}

extension AppInfo {
  public init(_ bundle: Bundle) {
    name = bundle.infoDictionary?["CFBundleName"] as? String ?? ""
    version = bundle.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    build = bundle.infoDictionary?["CFBundleVersion"] as? String ?? ""
    copyright = bundle.infoDictionary?["NSHumanReadableCopyright"] as? String ?? ""
  }
}

extension AppInfo {
  public static let stub = AppInfo(
    name: "App Name",
    version: "1.2.3",
    build: "456",
    copyright: "Copyright © 2024 Company Name. All rights reserved."
  )
}

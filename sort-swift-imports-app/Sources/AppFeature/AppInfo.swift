import Foundation

struct AppInfo: Equatable {
  var name: String
  var version: String
  var build: String
  var copyright: String
}

extension AppInfo {
  init(_ bundle: Bundle) {
    name = bundle.infoDictionary?["CFBundleName"] as? String ?? ""
    version = bundle.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    build = bundle.infoDictionary?["CFBundleVersion"] as? String ?? ""
    copyright = bundle.infoDictionary?["NSHumanReadableCopyright"] as? String ?? ""
  }
}

#if DEBUG
extension AppInfo {
  static let stub = Self(
    name: "App Name",
    version: "1.2.3",
    build: "456",
    copyright: "Copyright © 2021 Company Name. All rights reserved."
  )
}
#endif

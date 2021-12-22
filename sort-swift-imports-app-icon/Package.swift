// swift-tools-version:5.5

import PackageDescription

let package = Package(
  name: "sort-swift-imports-app-icon",
  platforms: [
    .macOS(.v12),
    .iOS(.v15),
  ],
  products: [
    .library(name: "AppIcon", targets: ["AppIcon"]),
    .executable(name: "ExportAppIcon", targets: ["ExportAppIcon"]),
  ],
  dependencies: [
    .package(
      name: "swiftui-app-icon-creator",
      url: "https://github.com/darrarski/swiftui-app-icon-creator.git",
      .upToNextMajor(from: "1.2.0")
    ),
  ],
  targets: [
    .target(name: "AppIcon", dependencies: [
      .product(name: "AppIconCreator", package: "swiftui-app-icon-creator"),
    ]),
    .executableTarget(name: "ExportAppIcon", dependencies: [
      .target(name: "AppIcon"),
    ]),
  ]
)

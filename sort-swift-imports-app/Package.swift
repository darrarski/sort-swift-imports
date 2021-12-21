// swift-tools-version:5.5

import PackageDescription

let package = Package(
  name: "sort-swift-imports-app",
  platforms: [
    .macOS(.v12),
  ],
  products: [
    .library(name: "AppFeature", targets: ["AppFeature"]),
  ],
  dependencies: [
    .package(name: "sort-swift-imports", path: "../")
  ],
  targets: [
    .target(name: "AppFeature", dependencies: [
      .product(name: "SortSwiftImports", package: "sort-swift-imports"),
    ]),
    .testTarget(name: "AppFeatureTests", dependencies: [
      .target(name: "AppFeature"),
    ]),
  ]
)

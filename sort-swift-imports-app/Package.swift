// swift-tools-version:5.5

import PackageDescription

let package = Package(
  name: "sort-swift-imports-app",
  platforms: [
    .macOS(.v12),
  ],
  products: [
    .library(name: "AppFeature", targets: ["AppFeature"]),
    .library(name: "EditorFeature", targets: ["EditorFeature"]),
  ],
  dependencies: [
    .package(name: "sort-swift-imports", path: "../"),
    .package(name: "sort-swift-imports-app-icon", path: "../sort-swift-imports-app-icon"),
    .package(
      name: "swift-composable-architecture",
      url: "https://github.com/pointfreeco/swift-composable-architecture.git",
      .upToNextMajor(from: "0.31.0")
    ),
    .package(
      name: "CodeEditor",
      url: "https://github.com/ZeeZide/CodeEditor.git",
      .upToNextMajor(from: "1.2.0")
    ),
  ],
  targets: [
    .target(name: "AppFeature", dependencies: [
      .target(name: "EditorFeature"),
      .product(name: "AppIcon", package: "sort-swift-imports-app-icon"),
    ]),
    .testTarget(name: "AppFeatureTests", dependencies: [
      .target(name: "AppFeature"),
    ]),
    .target(name: "EditorFeature", dependencies: [
      .product(name: "CodeEditor", package: "CodeEditor"),
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
      .product(name: "SortSwiftImports", package: "sort-swift-imports"),
    ]),
    .testTarget(name: "EditorFeatureTests", dependencies: [
      .target(name: "EditorFeature"),
    ]),
  ]
)

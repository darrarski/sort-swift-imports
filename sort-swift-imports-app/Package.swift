// swift-tools-version: 5.10
import PackageDescription

let package = Package(
  name: "sort-swift-imports-app",
  defaultLocalization: "en",
  platforms: [
    .macOS(.v14),
    .iOS(.v17),
  ],
  products: [
    .library(name: "AppFeature", targets: ["AppFeature"]),
    .library(name: "EditorFeature", targets: ["EditorFeature"]),
  ],
  dependencies: [
    .package(name: "sort-swift-imports", path: "../"),
    .package(name: "sort-swift-imports-app-icon", path: "../sort-swift-imports-app-icon"),
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", from: "1.10.4"),
    .package(url: "https://github.com/darrarski/CodeEditor.git", revision: "7ca0e4b"),
  ],
  targets: [
    .target(
      name: "AppFeature",
      dependencies: [
        .target(name: "EditorFeature"),
        .product(name: "AppIcon", package: "sort-swift-imports-app-icon"),
      ],
      resources: [
        .process("Resources"),
      ]
    ),
    .testTarget(
      name: "AppFeatureTests",
      dependencies: [
        .target(name: "AppFeature"),
      ]
    ),
    .target(
      name: "EditorFeature",
      dependencies: [
        .product(name: "CodeEditor", package: "CodeEditor"),
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        .product(name: "SortSwiftImports", package: "sort-swift-imports"),
      ]
    ),
    .testTarget(
      name: "EditorFeatureTests",
      dependencies: [
        .target(name: "EditorFeature"),
      ]
    ),
  ]
)

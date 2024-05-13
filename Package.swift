// swift-tools-version: 5.10
import PackageDescription

let package = Package(
  name: "sort-swift-imports",
  platforms: [
    .macOS(.v13),
    .iOS(.v15),
  ],
  products: [
    .library(name: "SortSwiftImports", targets: ["SortSwiftImports"]),
  ],
  targets: [
    .target(
      name: "SortSwiftImports"
    ),
    .testTarget(
      name: "SortSwiftImportsTests",
      dependencies: [
        .target(name: "SortSwiftImports"),
      ]
    ),
  ]
)

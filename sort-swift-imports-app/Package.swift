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
    .library(name: "AboutFeature", targets: ["AboutFeature"]),
    .library(name: "AcknowledgmentsFeature", targets: ["AcknowledgmentsFeature"]),
    .library(name: "AppFeature", targets: ["AppFeature"]),
    .library(name: "AppShared", targets: ["AppShared"]),
    .library(name: "EditorFeature", targets: ["EditorFeature"]),
    .library(name: "HelpFeature", targets: ["HelpFeature"]),
  ],
  dependencies: [
    .package(name: "sort-swift-imports", path: "../"),
    .package(name: "sort-swift-imports-app-icon", path: "../sort-swift-imports-app-icon"),
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", from: "1.10.4"),
    .package(url: "https://github.com/ZeeZide/CodeEditor.git", from: "1.2.4"),
    .package(url: "https://github.com/siteline/swiftui-introspect.git", from: "1.1.4"),
  ],
  targets: [
    .target(
      name: "AboutFeature",
      dependencies: [
        .target(name: "AcknowledgmentsFeature"),
        .target(name: "AppShared"),
        .product(name: "AppIcon", package: "sort-swift-imports-app-icon"),
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
      ]
    ),
    .testTarget(
      name: "AboutFeatureTests",
      dependencies: [
        .target(name: "AboutFeature"),
      ]
    ),
    .target(
        name: "AcknowledgmentsFeature",
        dependencies: [
          .target(name: "AppShared"),
          .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        ]
      ),
    .testTarget(
      name: "AcknowledgmentsFeatureTests",
      dependencies: [
        .target(name: "AcknowledgmentsFeature"),
      ]
    ),
    .target(
      name: "AppFeature",
      dependencies: [
        .target(name: "AboutFeature"),
        .target(name: "AcknowledgmentsFeature"),
        .target(name: "AppShared"),
        .target(name: "EditorFeature"),
        .target(name: "HelpFeature"),
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
      ]
    ),
    .testTarget(
      name: "AppFeatureTests",
      dependencies: [
        .target(name: "AppFeature"),
      ]
    ),
    .target(
      name: "AppShared",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
      ],
      resources: [
        .process("Resources"),
      ]
    ),
    .testTarget(
      name: "AppSharedTests",
      dependencies: [
        .target(name: "AppShared"),
      ]
    ),
    .target(
      name: "EditorFeature",
      dependencies: [
        .target(name: "AppShared"),
        .product(name: "CodeEditor", package: "CodeEditor"),
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        .product(name: "SortSwiftImports", package: "sort-swift-imports"),
        .product(name: "SwiftUIIntrospect", package: "swiftui-introspect"),
      ]
    ),
    .testTarget(
      name: "EditorFeatureTests",
      dependencies: [
        .target(name: "EditorFeature"),
      ]
    ),
    .target(
      name: "HelpFeature",
      dependencies: [
        .target(name: "AppShared"),
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
      ]
    ),
    .testTarget(
      name: "HelpFeatureTests",
      dependencies: [
        .target(name: "HelpFeature"),
      ]
    ),
  ]
)

extension Target {
  var isLocal: Bool { ![.binary, .system].contains(self.type) }
}

extension BuildSettingCondition {
  static let whenDebug = BuildSettingCondition.when(configuration: .debug)
}

extension SwiftSetting {
  static func enableActorDataRaceChecks(_ condition: BuildSettingCondition? = nil) -> SwiftSetting {
    .unsafeFlags(["-Xfrontend", "-enable-actor-data-race-checks"], condition)
  }
  static func debugTime(_ condition: BuildSettingCondition? = nil) -> SwiftSetting {
    .unsafeFlags(
      ["-Xfrontend", "-debug-time-function-bodies",
       "-Xfrontend", "-debug-time-expression-type-checking"],
      condition
    )
  }
}

for target in package.targets where target.isLocal {
  var swiftSettings = target.swiftSettings ?? []
  swiftSettings.append(.enableActorDataRaceChecks(.whenDebug))
  swiftSettings.append(.debugTime(.whenDebug))
#if !hasFeature(ConciseMagicFile)
  swiftSettings.append(.enableUpcomingFeature("ConciseMagicFile"))
#endif
#if !hasFeature(ForwardTrailingClosures)
  swiftSettings.append(.enableUpcomingFeature("ForwardTrailingClosures"))
#endif
#if !hasFeature(StrictConcurrency)
  swiftSettings.append(.enableUpcomingFeature("StrictConcurrency"))
  swiftSettings.append(.enableExperimentalFeature("StrictConcurrency"))
#endif
#if !hasFeature(BareSlashRegexLiterals)
  swiftSettings.append(.enableUpcomingFeature("BareSlashRegexLiterals"))
#endif
#if !hasFeature(ImplicitOpenExistentials)
  swiftSettings.append(.enableUpcomingFeature("ImplicitOpenExistentials"))
#endif
#if !hasFeature(ImportObjcForwardDeclarations)
  swiftSettings.append(.enableUpcomingFeature("ImportObjcForwardDeclarations"))
#endif
#if !hasFeature(DisableOutwardActorInference)
  swiftSettings.append(.enableUpcomingFeature("DisableOutwardActorInference"))
#endif
#if !hasFeature(InternalImportsByDefault)
  swiftSettings.append(.enableUpcomingFeature("InternalImportsByDefault"))
#endif
#if !hasFeature(IsolatedDefaultValues)
  swiftSettings.append(.enableUpcomingFeature("IsolatedDefaultValues"))
#endif
#if !hasFeature(GlobalConcurrency)
  swiftSettings.append(.enableUpcomingFeature("GlobalConcurrency"))
#endif
#if !hasFeature(ExistentialAny)
  swiftSettings.append(.enableUpcomingFeature("ExistentialAny"))
#endif
  target.swiftSettings = swiftSettings
}

# Sort Swift Imports

![Swift 5.5](https://img.shields.io/badge/swift-5.5-orange.svg)
![platform macOS](https://img.shields.io/badge/platform-macOS-blue.svg)

Sort `import` statements in Swift source code.

- Swift Library
- macOS app
    - Xcode Source Editor Extension
- iOS app

## 🛠 Setup

- Xcode 13.2

Open `SortSwiftImports.xcworkspace` in Xcode for development.

### Workspace structure

```
SortSwiftImports (Xcode Workspace)
 ├─ sort-swift-imports (Swift Package)
 |   └─ SortSwiftImports (Library)
 ├─ sort-swift-imports-app (Swift Package)
 |   ├─ AppFeature (Library)
 |   └─ EditorFeature (Library)
 ├─ sort-swift-imports-app-icon (Swift Package)
 |   ├─ AppIcon (Library)
 |   └─ AppIconExport (macOS executable)
 └─ Project (Xcode Project)
     ├─ SortSwiftImportsMacApp (macOS Application)
     ├─ SortSwiftImportsIOSApp (iOS Application)
     └─ SortSwiftImportsXcodeExtension (Xcode Source Editor Extension)
```

### Build schemes

- Use `SortSwiftImportsMacApp` scheme to build and run the macOS application.
- Use `SortSwiftImportsMacApp` scheme to run all tests on macOS.
- Use `SortSwiftImportsIOSApp` scheme to build and run the iOS application.
- Use `SortSwiftImportsIOSApp` scheme to run all tests on iOS simulator.
- Use `SortSwiftImportsXcodeExtension` scheme to build and run the Xcode Source Editor Extension. 
- Use `AppIcon` scheme for building & previewing the app icon in Xcode (use macOS destination).
- Use `ExportAppIcon` scheme for exporting the app icon into asset catalog (use macOS destination).

Use other schemes for building and testing the libraries.

## 📄 License

Copyright © 2021 Dariusz Rybicki Darrarski

License: [MIT](LICENSE)

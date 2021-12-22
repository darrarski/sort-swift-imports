# Sort Swift Imports

![Swift 5.5](https://img.shields.io/badge/swift-5.5-orange.svg)
![platform macOS](https://img.shields.io/badge/platform-macOS-blue.svg)

Sort `import` statements in Swift source code.

- Swift Library
- macOS app
- Xcode Source Editor Extension

## 🛠 Setup

- Xcode 13.2

Open `SortSwiftImports.xcworkspace` in Xcode for development.

### Workspace structure

```
SortSwiftImports (Xcode Workspace)
 ├─ sort-swift-imports (Swift Package)
 |   └─ SortSwiftImports (Library)
 ├─ sort-swift-imports-app (Swift Package)
 |   └─ EditorFeature (Library)
 ├─ sort-swift-imports-app-icon (Swift Package)
 |   ├─ AppIcon (Library)
 |   └─ AppIconExport (macOS executable)
 ├─ Project (Xcode Project)
 |   ├─ SortSwiftImportsApp (macOS Application)
 |   └─ SortSwiftImportsExtension (Xcode Source Editor Extension)
 └─ Tests (Xcode Test Plan)
```

### Build schemes

- Use `SortSwiftImportsApp` scheme to build and run the application, and run the included test plan.
- Use `SortSwiftImportsExtension` scheme to build and run the Xcode extension. 
- Use `AppIcon` scheme for building & previewing the app icon in Xcode.
- Use `ExportAppIcon` scheme for exporting the app icon into asset catalog.

Use other schemes for building and testing the libraries.

## 📄 License

Copyright © 2021 Dariusz Rybicki Darrarski

License: TBD

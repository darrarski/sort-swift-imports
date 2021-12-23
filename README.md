# Sort Swift Imports

![Swift 5.5](https://img.shields.io/badge/swift-5.5-orange.svg)
![platform macOS iOS](https://img.shields.io/badge/platform-macOS_|_iOS-blue.svg)

Sort `import` statements in Swift source code.

### Swift Library

Add as a dependency to your Swift Package and use in your projects:

```swift
import SortSwiftImports

let sortSwiftImports: SortSwiftImports = .live
let code: String = // swift source code
let result = sortSwiftImports(in: code)
switch result {
case let .success(output):
  print(output)
case let .failure(error):
  print(error)
}
```

### macOS application

|macOS|
|:-:|
|![macOS app screenshot light mode](Misc/Screenshots/macOS/macOS%201.png#gh-light-mode-only)![macOS app screenshot dark mode](Misc/Screenshots/macOS/macOS%202.png#gh-dark-mode-only)|

### iOS application

|iPhone|iPad|
|:-:|:-:|
|![iPhone app screenshot light mode](Misc/Screenshots/iPhone%205.5in/iPhone%205.5in%201.png#gh-light-mode-only)![iPhone app screenshot dark mode](Misc/Screenshots/iPhone%205.5in/iPhone%205.5in%202.png#gh-dark-mode-only)|![iPad app screenshot light mode](Misc/Screenshots/iPad%20Pro%2012.9in%202nd%20gen/iPad%20Pro%2012.9in%202nd%20gen%201.png#gh-light-mode-only)![iPad app screenshot dark mode](Misc/Screenshots/iPad%20Pro%2012.9in%202nd%20gen/iPad%20Pro%2012.9in%202nd%20gen%202.png#gh-dark-mode-only)|

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

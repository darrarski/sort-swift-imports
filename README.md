# Sort (Swift) Imports

![Swift 5.10](https://img.shields.io/badge/swift-5.10-orange.svg)
![platform macOS iOS](https://img.shields.io/badge/platform-macOS_|_iOS-blue.svg)

Sort `import` statements in your Swift source code.

## 🏛 Swift Library

Add `sort-swift-imports` package dependency to your Swift Package:

```swift
.package(
  url: "https://github.com/darrarski/sort-swift-imports.git",
  from: "1.0.0"
),
```

Add `SortSwiftImports` library as a dependency to your targets: 

```swift
.product(
  name: "SortSwiftImports", 
  package: "sort-swift-imports"
),
```

Use `SortSwiftImports` from your code:

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

## 🅰️ macOS application

<a href="https://apps.apple.com/app/sort-imports/id1601715398">
  <img src="Misc/Download_on_the_App_Store_badge.png" alt="Download on the App Store" align="right" width="200"/>
</a>

Native **SwiftUI** macOS application that you can use to sort imports in your Swift source code. Just paste your code and click the `Sort swift imports` button.

It also contains **Xcode Source Editor extension**so that you can sort your Swift imports directly from Xcode. Ensure you have enabled `Sort Imports` extension in `System Preferences` → `Extensions` → `Xcode Source Editor`.

|macOS|
|:-:|
|![macOS app screenshot light mode](Misc/Screenshots/macOS/macOS-light-1.png#gh-light-mode-only)![macOS app screenshot dark mode](Misc/Screenshots/macOS/macOS-dark-1.png#gh-dark-mode-only)|

## 🅰️ iOS application

<a href="https://apps.apple.com/app/sort-imports/id1601715398">
  <img src="Misc/Download_on_the_App_Store_badge.png" alt="Download on the App Store" align="right" width="200"/>
</a>

Native **SwiftUI** iOS application that you can use to sort imports in your Swift source code. Just paste your code and tap `⚙️` → `Sort swift imports`.

On your iPad, you can use multiple windows of the app simultaneously.

|iPhone|iPad|
|:-:|:-:|
|![iPhone app screenshot light mode](Misc/Screenshots/iPhone-5.5in/iPhone-5.5in-light-1.png#gh-light-mode-only)![iPhone app screenshot dark mode](Misc/Screenshots/iPhone-5.5in/iPhone-5.5in-dark-1.png#gh-dark-mode-only)|![iPad app screenshot light mode](Misc/Screenshots/iPad-Pro-12.9in-2nd-gen/iPad-Pro-12.9in-2nd-gen-light-1.png#gh-light-mode-only)![iPad app screenshot dark mode](Misc/Screenshots/iPad-Pro-12.9in-2nd-gen/iPad-Pro-12.9in-2nd-gen-dark-1.png#gh-dark-mode-only)|

## 🛠 Development

Open `SortSwiftImports.xcworkspace` in Xcode (⩾15.4) for development.

### 🧰 Workspace structure

```
SortSwiftImports (Xcode Workspace)
 ├─ sort-swift-imports (Swift Package)
 │   └─ SortSwiftImports (Library)
 ├─ sort-swift-imports-app (Swift Package)
 │   ├─ AppFeature (Library)
 │   └─ EditorFeature (Library)
 ├─ sort-swift-imports-app-icon (Swift Package)
 │   ├─ AppIcon (Library)
 │   └─ AppIconExport (macOS executable)
 └─ Project (Xcode Project)
     ├─ SortSwiftImportsApp (iOS and macOS Application)
     └─ SortSwiftImportsXcodeExtension (Xcode Source Editor Extension)
```

### ▶️ Build schemes

- Use `SortSwiftImportsMacApp` scheme to build and run the macOS application.
- Use `SortSwiftImportsMacApp` scheme to run all tests on macOS.
- Use `SortSwiftImportsIOSApp` scheme to build and run the iOS application.
- Use `SortSwiftImportsIOSApp` scheme to run all tests on iOS simulator.
- Use `SortSwiftImportsXcodeExtension` scheme to build and run the Xcode Source Editor Extension. 
- Use `AppIcon` scheme for building & previewing the app icon in Xcode (use macOS destination).
- Use `ExportAppIcon` scheme for exporting the app icon into asset catalog (use macOS destination).

Use other schemes for building and testing the libraries.

### 🙋‍♂️ Contributing

- All contributions are welcome!
- Create a pull request containing your changes or bug fixes.
- Make sure to add tests for the new/updated code.

## ☕️ Do you like the project?

<a href="https://www.buymeacoffee.com/darrarski" target="_blank">
  <img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" align="right" height="60"/>
</a>

Consider supporting further development and buy me a coffee.

&nbsp;

## 📄 License

Copyright © 2021 Dariusz Rybicki Darrarski

License: [MIT](LICENSE)

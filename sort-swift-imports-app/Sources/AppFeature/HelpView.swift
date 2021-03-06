import SwiftUI

struct HelpView: View {
  var body: some View {
    VStack(alignment: .leading) {
      Text("Paste your swift source code and use \"Sort swift imports\" button to sort imports.")
        .padding(.bottom)

      #if os(macOS)
      Text("You can also sort imports directly from Xcode, using included Xcode Source Editor Extension. Make sure you have enabled Sort Imports extension in System Preferences → Extensions. If you can't see the extension in Xcode's Editor menu, check out this article:")

      Link(destination: URL(string: "https://nshipster.com/xcode-source-extensions/#using-pluginkit")!) {
        Label(
          "Xcode​Kit and Xcode Source Editor Extensions - Using pluginkit",
          systemImage: "link"
        )
          #if os(iOS)
          .padding()
          #endif
      }
      .padding(.bottom)
      #endif

      Text("For feedback and support, visit website:")

      Link(destination: URL(string: "https://sort-swift-imports.darrarski.pl")!) {
        Label(
          "Sort Imports Website",
          systemImage: "link"
        )
          #if os(iOS)
          .padding()
          #endif
      }
    }
    .fixedSize(horizontal: false, vertical: true)
    .padding()
    .padding()
    #if os(macOS)
    .frame(width: 480, alignment: .topLeading)
    #endif
  }
}

#if DEBUG
struct HelpView_Previews: PreviewProvider {
  static var previews: some View {
    HelpView()
  }
}
#endif

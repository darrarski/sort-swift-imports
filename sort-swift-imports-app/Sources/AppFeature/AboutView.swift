import AppIcon
import SwiftUI

struct AboutView: View {
  var appInfo: AppInfo

  var body: some View {
    VStack {
      AppIconView(.macOS)
        .frame(width: 128, height: 128)
        .shadow(color: .black, radius: 1, x: 1, y: 1)

      Text(appInfo.name)
        .font(.title)
        .padding(.bottom)

      Text("Version \(appInfo.version) build \(appInfo.build)")
        .padding(.bottom)

      Text(appInfo.copyright)
        .padding(.bottom)

      VStack(alignment: .leading) {
        Link(destination: URL(string: "https://sort-swift-imports.darrarski.pl")!) {
          Label("\(appInfo.name) Website", systemImage: "link")
            #if os(iOS)
            .padding()
            #endif
        }

        Link(destination: URL(string: "https://darrarski.pl")!) {
          Label("Dariusz Rybicki Darrarski", systemImage: "link")
            #if os(iOS)
            .padding()
            #endif
        }
      }
      .padding(.bottom)

      AcknowledgmentsButton()
    }
    .multilineTextAlignment(.center)
    #if os(macOS)
    .fixedSize(horizontal: true, vertical: false)
    #endif
    .padding()
    .padding()
  }
}

#if DEBUG
struct AboutView_Previews: PreviewProvider {
  static var previews: some View {
    AboutView(appInfo: .stub)
  }
}
#endif

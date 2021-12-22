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
        }

        Link(destination: URL(string: "https://darrarski.pl")!) {
          Label("Dariusz Rybicki Darrarski", systemImage: "link")
        }
      }
    }
    .fixedSize(horizontal: true, vertical: false)
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

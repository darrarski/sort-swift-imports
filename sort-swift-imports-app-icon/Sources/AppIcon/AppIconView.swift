import SwiftUI
import AppIconCreator

public struct AppIconView: View {
  public enum Platform: Equatable {
    case macOS
    case iOS
  }

  public init(_ platform: Platform) {
    self.platform = platform
  }

  var platform: Platform

  public var body: some View {
    GeometryReader { geometry in
      Image(systemName: "arrow.up.arrow.down")
        .resizable()
        .scaledToFit()
        .font(Font.body.bold())
        .foregroundColor(.white)
        .padding(geometry.size.width * 0.18)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
          LinearGradient(
            gradient: Gradient(colors: [.clear, .black.opacity(0.33)]),
            startPoint: .top,
            endPoint: .bottom
          )
        )
        .background(Color.orange)
        .if(platform == .macOS) {
          $0.clipShape(RoundedRectangle(
            cornerRadius: geometry.size.width * 0.2,
            style: .continuous
          )).padding(geometry.size.width * 0.08)
        }
    }
  }
}

#if os(macOS)
struct AppIconView_Preivews: PreviewProvider {
  static var previews: some View {
    IconPreviews(
      icon: AppIconView(.iOS),
      configs: .iOS,
      clip: true
    )

    IconPreviews(
      icon: AppIconView(.macOS),
      configs: .macOS,
      clip: false
    )
  }
}
#endif

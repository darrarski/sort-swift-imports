import SwiftUI
import AppIconCreator

public struct AppIconView: View {
  public init() {}

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
        .clipShape(borderShape(iconSize: geometry.size))
        .padding(geometry.size.width * 0.08)
    }
  }

  func borderShape(iconSize size: CGSize) -> some InsettableShape {
    RoundedRectangle(
      cornerRadius: size.width * 0.2,
      style: .continuous
    )
  }
}

#if os(macOS)
struct AppIconView_Preivews: PreviewProvider {
  static var previews: some View {
    IconPreviews(
      icon: AppIconView(),
      configs: .macOS,
      clip: false
    )
  }
}
#endif

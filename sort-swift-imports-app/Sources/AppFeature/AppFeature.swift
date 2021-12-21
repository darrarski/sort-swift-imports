import SortSwiftImports
import SwiftUI

public struct AppView: View {
  public init() {}

  public var body: some View {
    Text("AppView")
      .padding()
      .frame(minWidth: 400, minHeight: 300)
  }
}

#if DEBUG
public struct AppView_Previews: PreviewProvider {
  public static var previews: some View {
    AppView()
  }
}
#endif

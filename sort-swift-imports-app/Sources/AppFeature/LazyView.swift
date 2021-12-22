import SwiftUI

struct LazyView<Content>: View where Content: View {
  var content: () -> Content
  var body: some View { content() }
}

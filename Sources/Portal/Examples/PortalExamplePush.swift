import SwiftUI

private struct DemoItem: Identifiable, Hashable {
    let id: Int
}

private struct ContentView2: View {
  @State private var path: [DemoItem] = []
  @Namespace private var namespace

  let items = (0..<10).map { DemoItem(id: $0) }

  var body: some View {
    PortalContainer {
      NavigationStack(path: $path) {
        ScrollView {
          VStack {
            ForEach(items) { item in
              HStack {
                Color.red
                  .frame(width: 100, height: 100)
                  .clipShape(.circle)
                  .portal(item: item, .source)
                Text("Some text title")
              }
              .frame(maxWidth: .infinity, alignment: .leading)
              .onTapGesture {
                path = [item]
              }
            }
          }
        }
        .navigationDestination(for: DemoItem.self) { item in
          ScrollView {
            VStack(alignment: .leading) {
              HStack {
                Color.red
                  .frame(width: 100, height: 100)
                  .clipShape(.circle)
                  .portal(item: item, .destination)
                Text("Some text bla bla bla bla")
              }
            }
          }
        }
        .portalTransition(
          items: $path,
          groupID: "example",
          animation: Animation.smooth(duration: 0.3, extraBounce: 0.25)
        ) { item in
          Color.red
            .frame(width: 100, height: 100)
            .clipShape(.circle)
        }
      }
    }
  }
}

#Preview {
  ContentView2()
}

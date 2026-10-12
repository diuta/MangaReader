import SwiftUI
import Playgrounds

struct ContentView: View {
    let driver = MangaDexClient()
    
    var body: some View {
        Text("Hello, world!")
            .padding()
            .task {
                do {
                    let mangas = try await driver.searchManga(title: "")
                    for manga in mangas {
                        print(manga.title)
                    }
                } catch {
                    print(error)
                }
            }
    }
}

#Preview {
    ContentView()
}

#Playground {
    _ = 1 + 2
}

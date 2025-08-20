import SwiftUI

struct ColorView: View {
    @State private var bgColor = Color.red

    var body: some View {
        VStack {
            Rectangle()
                .fill(bgColor)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onAppear {
            networkCallFunction()
        }
    }
}

func networkCallFunction() {
    print("before the network call")
    
    URLSession.shared.downloadTask(with: URLRequest(url: URL(string: "https://swapi.dev/api/people/1")!)) { _, _, _ in
        print("Inside the network call")
    }.resume()
    
    print("after the network call")
}

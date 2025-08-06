struct ContentView: View {
    init() {
        print("Init")
    }

    var body: some View {
        Text("Hello SwiftUI")
            .onAppear {
                print("View appeared")
            }
            .onDisappear {
                print("View disappeared")
            }
    }
}

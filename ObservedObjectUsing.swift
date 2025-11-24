import SwiftUI

// 1️⃣ Observable class
class CounterViewModel: ObservableObject {
    @Published var count = 0
}

struct ParentView: View {
    @StateObject var viewModel = CounterViewModel() // Created here

    var body: some View {
        VStack {
            Text("Parent Count: \(viewModel.count)")
            ChildView(viewModel: viewModel) // Passing to child
        }
    }
}

struct ChildView: View {
    @ObservedObject var viewModel: CounterViewModel // Observing same object

    var body: some View {
        VStack {
            Text("Child Count: \(viewModel.count)")
            Button("Add") {
                viewModel.count += 1
            }
        }
    }
}

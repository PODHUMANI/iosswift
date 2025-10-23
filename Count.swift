import SwiftUI

struct CounterView: View {
    @State private var count = 0

    var body: some View {
        VStack {
            Text("Count: \(count)")
            HStack {
                Button("-") { count -= 1 }
                Button("+") { count += 1 }
            }
        }
    }
}

import SwiftUI

struct ContentView: View {
    @State private var inputText = ""
    @State private var showText = ""

    var body: some View {
        VStack(spacing: 20) {
            
            Text(" \(showText)")
                .font(.title2)
                .foregroundColor(.green)

           
            
            TextField("Enter something...", text: $inputText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Show Text") {
                showText = inputText
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)

            Spacer()
        }
        .padding()
    }
}
#Preview{
    
    ContentView()
}

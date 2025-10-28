struct ContentView: View {

    @State private var name = ""
    @State private var resultText = ""   // backend thirumba kudukkura data show panna

    var body: some View {
        VStack(spacing: 20) {

            TextField("Enter Name", text: $name)
                .textFieldStyle(.roundedBorder)

            Button("Send to Backend") {
                callAPI(name: name)
            }

            Text("Response: \(resultText)") // Display backend response
                .foregroundColor(.blue)
        }
        .padding()
    }

    func callAPI(name: String) {

        // Url
        guard let url = URL(string: "https://example.com/api") else { return }

        // JSON body
        let body: [String: Any] = ["userName": name]
        let jsonData = try! JSONSerialization.data(withJSONObject: body)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        // Task
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let data = data {
                // Assume server returns {"message":"Saved Successfully"}
                if let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    DispatchQueue.main.async {
                        self.resultText = dict["message"] as? String ?? "No message"
                    }
                }
            }
        }.resume()
    }
}

@State private var name: String = ""

var body: some View {
    VStack {
        TextField("Enter name", text: $name)
            .textFieldStyle(.roundedBorder)

        Button("Submit") {
            if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                print("Name is empty")
            } else {
                print("Name entered: \(name)")
            }
        }
    }
}

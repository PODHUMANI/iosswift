struct ContentView: View {
    @State private var items = ["Apple", "Banana", "Orange"]

    var body: some View {
        List {
            ForEach(items, id: \.self) { item in
                Text(item)
            }
            .onDelete(perform: deleteItem)
        }
    }

    func deleteItem(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
}

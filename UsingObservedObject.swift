struct ParentView: View {
    @StateObject private var model = CounterModel()
    
    var body: some View {
        ChildView(model: model)
    }
}

struct ChildView: View {
    @ObservedObject var model: CounterModel
    
    var body: some View {
        Button("Increase") {
            model.count += 1
        }
    }
}

WindowGroup {
    ContentView()
        .environment(\.managedObjectContext, dataController.container.viewContext)
}

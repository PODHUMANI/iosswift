func fetchMainFood() {
    let request: NSFetchRequest<AppEntity> = AppEntity.fetchRequest()
    request.predicate = NSPredicate(format: "category CONTAINS[c] %@", "main")  // category = "main" foods
    do {
        mainFod = try context.fetch(request)
    } catch {
        print("Fetch error: \(error)")
    }
}

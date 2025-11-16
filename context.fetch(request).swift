let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

let request = Person.fetchRequest()

do {
    let persons = try context.fetch(request)
    print(persons)
} catch {
    print("Error")
}

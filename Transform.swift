import Foundation
import CoreData

class UserViewModel: ObservableObject {
    let context = PersistenceController.shared.container.viewContext
    
    @Published var users: [UserEntity] = []
    
    func addUser(name: String, emails: [String]) {
        let newUser = UserEntity(context: context)
        newUser.name = name
        newUser.emails = emails as NSObject   // Array store
        
        saveContext()
        fetchUsers()
    }
    
    func fetchUsers() {
        let request = NSFetchRequest<UserEntity>(entityName: "UserEntity")
        do {
            users = try context.fetch(request)
        } catch {
            print("Fetch error: \(error)")
        }
    }
    
    func saveContext() {
        do { try context.save() }
        catch { print("Save error: \(error)") }
    }
}

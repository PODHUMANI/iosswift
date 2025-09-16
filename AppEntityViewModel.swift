import Foundation
import CoreData
import PhotosUI

class AppEntityViewModel : ObservableObject{
    let context = PersistenceController.shared.container.viewContext
 //   @Published var loggedInUser: AppEntity?
   
    @Published var menus: [AppEntity] = []
       @Published var searchText: String = ""

    func signUp(username :String,email :String,password : String , role :String) -> Bool{
               let fetchRequest: NSFetchRequest<AppEntity> = AppEntity.fetchRequest()
 fetchRequest.predicate = NSPredicate(format: "username == %@ AND password == %@", username, password)
        do {
            let existingUsers = try context.fetch(fetchRequest)
            if !existingUsers.isEmpty {
                print("Username already exists!")
                return false
            }
        let newUser = AppEntity(context: context)
        newUser.id = UUID()
        newUser.role = role
        newUser.username = username
        newUser.password = password
        newUser.email = email
        try context.save()
        print("User registered successfully")
        return true
    } catch {
        print("Failed to save user: \(error)")
        return false
    }    }
    private func saveContext() {
        do {
            try context.save()
        } catch {
            print(" Error saving context: \(error)")
        }
    }
    func login(username : String,password : String) -> Bool{
        let fetchRequest: NSFetchRequest<AppEntity> = AppEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "username == %@ AND password == %@", username, password)
        
        do {
            let users = try context.fetch(fetchRequest)
            return !users.isEmpty
        } catch {
            print("Login validation failed: \(error)")
            return false
        }
    }
   
      init() {
          fetchFoods()
      }
      func fetchFoods() {
          let request: NSFetchRequest<AppEntity> = AppEntity.fetchRequest()
          if !searchText.isEmpty {
              request.predicate = NSPredicate(format: "title CONTAINS[c] %@", searchText)
          }
          do {
              menus = try context.fetch(request)
          } catch {
              print("Fetch error: \(error)")
          }
      }
      
      func addFood(foodname: String, discription: String, category: String, price: String/*, image: UIImage?*/) {
          let newFood = AppEntity(context: context)
          newFood.id = UUID()
          newFood.foodname = foodname
          newFood.discription = discription
          newFood.category = category
          newFood.price = price
         newFood.image = "foodbg"/*imageToString(image)*/
      
          save()
      }
      
      func deleteFood(food: AppEntity) {
          context.delete(food)
          save()
      }
      func save() {
          do {
              try context.save()
              fetchFoods()
          } catch {
              print("Save error: \(error)")
          }
      }
      func imageToString(_ image: UIImage) -> String {
          if let data = image.jpegData(compressionQuality: 0.8) {
              return data.base64EncodedString()
          }
          return ""
      }
      
      func stringToImage(_ str: String?) -> UIImage? {
          guard let str = str,
                let data = Data(base64Encoded: str) else { return nil }
          return UIImage(data: data)
      }
    var filteredMenu : [AppEntity]{
        let text =  searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        if text.isEmpty { return menus }
        return menus.filter{menu in
            if menu.foodname?.lowercased().contains(text) == true { return true}
            if menu.category?.lowercased().contains(text) == true { return true }
        
            let status = menu.status ? "complete" : "pending"
            if status.contains(text) { return true }
            return false
        }
        
    }

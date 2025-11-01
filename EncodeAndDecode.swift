struct User: Codable {
    var name: String
    var age: Int
}

// Save
let user = User(name: "Podhumani", age: 25)
if let encoded = try? JSONEncoder().encode(user) {
    UserDefaults.standard.set(encoded, forKey: "savedUser")
}

// Get
if let savedData = UserDefaults.standard.data(forKey: "savedUser"),
   let savedUser = try? JSONDecoder().decode(User.self, from: savedData) {
    print(savedUser.name) // Podhumani
}

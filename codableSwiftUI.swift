func saveToUserDefaults(user: User) {
    if let data = try? JSONEncoder().encode(user) {
        UserDefaults.standard.set(data, forKey: "savedUser")
    }
}

func loadFromUserDefaults() -> User? {
    if let data = UserDefaults.standard.data(forKey: "savedUser"),
       let user = try? JSONDecoder().decode(User.self, from: data) {
        return user
    }
    return nil
}

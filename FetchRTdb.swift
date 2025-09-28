func fetchUsers(completion: @escaping ([User]) -> Void) {
    ref.child("users").observe(.value) { snapshot in
        var fetchedUsers: [User] = []
        
        for child in snapshot.children {
            if let snap = child as? DataSnapshot,
               let dict = snap.value as? [String: Any],
               let name = dict["name"] as? String,
               let age = dict["age"] as? Int {
                
                let user = User(id: snap.key, name: name, age: age)
                fetchedUsers.append(user)
            }
        }
        completion(fetchedUsers)
    }
}

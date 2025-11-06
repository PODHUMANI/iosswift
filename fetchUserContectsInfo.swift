func fetchUserContectsInfo() {
    realtimeDB.child("selectedUsers").observe(.value) { snapshot in
        var allUserContectsInfo: [ContectsList] = []
        for child in snapshot.children {
            if let snap = child as? DataSnapshot,
               let data = snap.value as? [String: Any],
               let name = data["name"] as? String,
               let email = data["email"] as? String {
                
                let contect = ContectsList(id: snap.key,
                                           receiverusername: name,
                                           receiveremail: email)
                allUserContectsInfo.append(contect)
            }
        }
        DispatchQueue.main.async {
            self.contect = allUserContectsInfo
        }
    }
}

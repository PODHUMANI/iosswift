import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct ContentView: View {
    let db = Firestore.firestore()
    
    var body: some View {
        VStack {
            Button("Create User") {
                Auth.auth().createUser(withEmail: "test@gmail.com", password: "123456") { result, error in
                    if let error = error {
                        print("Error: \(error.localizedDescription)")
                    } else {
                        print("User ID: \(result?.user.uid ?? "")")
                    }
                }
            }
            
            Button("Add Data") {
                db.collection("users").addDocument(data: [
                    "name": "Podhumani",
                    "role": "iOS Developer"
                ])
            }
        }
    }
}

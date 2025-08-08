import SwiftUI
import CoreData

struct LoginView: View {
    @Environment(\.managedObjectContext) private var context

    @State private var username = ""
    @State private var password = ""
    
    @State private var loginMessage = ""
    @State private var showAlert = false

    var body: some View {
        VStack(spacing: 20) {
            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button("Login") {
                login()
            }

            .padding()
        }
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Login Status"), message: Text(loginMessage), dismissButton: .default(Text("OK")))
        }
    }

    private func login() {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "username == %@ AND password == %@", username, password)

        do {
            let result = try context.fetch(fetchRequest)
            if result.first != nil {
                loginMessage = "✅ Login successful!"
            } else {
                loginMessage = "❌ Invalid username or password"
            }
        } catch {
            loginMessage = "❌ Error checking login"
        }
        showAlert = true
    }
}

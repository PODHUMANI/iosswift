import SwiftUI
import FirebaseAuth   // Firebase Authentication use panna

struct ContentView: View {
    @State private var email = ""      // User type panna Email store panna
    @State private var password = ""   // User type panna Password store panna
    @State private var message = ""    // Success/Error message kaamikka

    var body: some View {
        VStack(spacing: 20) {  // Vertical layout, 20 gap
            TextField("Email", text: $email)   // Email input field
                .textFieldStyle(RoundedBorderTextFieldStyle())  // UI style
            
            SecureField("Password", text: $password)   // Secure input (password hidden)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button("Sign Up") {   // SignUp button
                signUp()
            }
            
            Button("Login") {     // Login button
                login()
            }

            Text(message)     // Result message show panna
                .foregroundColor(.red) // Red color la error/response show panna
        }
        .padding() // Entire VStack ku padding
    }

    // 🔹 New User create panna function
    func signUp() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                // Error irundha message show pannum
                message = error.localizedDescription
            } else {
                // Success ah user create aagum
                message = "User created: \(result?.user.email ?? "")"
            }
        }
    }

    // 🔹 Existing User login panna function
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                // Login fail na error message
                message = error.localizedDescription
            } else {
                // Login success na message
                message = "Logged in: \(result?.user.email ?? "")"
            }
        }
    }
}

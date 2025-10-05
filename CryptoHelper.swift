import Foundation
import CryptoKit

struct CryptoHelper {
    // 32-byte AES key
    private static let keyString = "ThisIsA32ByteLengthKeyForAES1234" // 👈 32 characters
    private static let key = SymmetricKey(data: keyString.data(using: .utf8)!)

    static func encrypt(_ text: String) -> String? {
        guard let data = text.data(using: .utf8) else { return nil }
        do {
            let sealedBox = try AES.GCM.seal(data, using: key)
            let combined = sealedBox.combined!
            return combined.base64EncodedString()
        } catch {
            print("❌ Encryption Error: \(error)")
            return nil
        }
    }

    static func decrypt(_ base64: String) -> String? {
        guard let data = Data(base64Encoded: base64) else { return nil }
        do {
            let sealedBox = try AES.GCM.SealedBox(combined: data)
            let decryptedData = try AES.GCM.open(sealedBox, using: key)
            return String(data: decryptedData, encoding: .utf8)
        } catch {
            print("❌ Decryption Error: \(error)")
            return nil
        }
    }
}
import Foundation

struct User: Codable {
    let username: String
    let password: String
}

class APIService {
    static let shared = APIService()
    private init() {}

    let baseURL = "https://yourapi.com/users"  // 👈 change to your API endpoint

    // POST user (encrypt before sending)
    func saveUser(username: String, password: String, completion: @escaping (Bool) -> Void) {
        guard let encUser = CryptoHelper.encrypt(username),
              let encPass = CryptoHelper.encrypt(password) else {
            print("Encryption failed!")
            completion(false)
            return
        }

        let user = User(username: encUser, password: encPass)
        guard let url = URL(string: baseURL) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONEncoder().encode(user)
        } catch {
            print("Encoding Error: \(error)")
            completion(false)
            return
        }

        URLSession.shared.dataTask(with: request) { _, response, error in
            if let error = error {
                print("❌ POST Error: \(error)")
                completion(false)
                return
            }
            completion(true)
        }.resume()
    }

    // GET users (decrypt after fetching)
    func fetchUsers(completion: @escaping ([User]) -> Void) {
        guard let url = URL(string: baseURL) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("❌ GET Error: \(error)")
                completion([])
                return
            }
            guard let data = data else { return }
            do {
                let fetchedUsers = try JSONDecoder().decode([User].self, from: data)

                // 🔓 Decrypt each user
                let decryptedUsers = fetchedUsers.map { user in
                    let decUsername = CryptoHelper.decrypt(user.username) ?? "DecryptFail"
                    let decPassword = CryptoHelper.decrypt(user.password) ?? "DecryptFail"
                    return User(username: decUsername, password: decPassword)
                }

                DispatchQueue.main.async {
                    completion(decryptedUsers)
                }
            } catch {
                print("❌ JSON Error: \(error)")
                completion([])
            }
        }.resume()
    }
}
import SwiftUI

struct ContentView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var users: [User] = []

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("Enter Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                SecureField("Enter Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                Button("Save User") {
                    APIService.shared.saveUser(username: username, password: password) { success in
                        if success {
                            print("✅ User saved to API")
                        }
                    }
                }
                .buttonStyle(.borderedProminent)
                .padding()

                Button("Fetch Users") {
                    APIService.shared.fetchUsers { fetched in
                        self.users = fetched
                    }
                }
                .buttonStyle(.bordered)

                List(users, id: \.username) { user in
                    VStack(alignment: .leading) {
                        Text("👤 Username: \(user.username)")
                        Text("🔑 Password: \(user.password)")
                    }
                }
            }
            .navigationTitle("🔐 Encryption Demo")
        }
    }
}

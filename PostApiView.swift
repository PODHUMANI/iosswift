import SwiftUI

struct PostApiView: View {
    @StateObject private var viewModel = PostApiJsonViewModel()
    @State var name = ""
    @State var password = ""
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading...")
            }
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
            List {
                ForEach(viewModel.userInfo) { item in
                    VStack(alignment: .leading) {
                        Text("Username : \(item.username)")
                        HStack {
                            Button("Delete") {
                                Task {
                                    await viewModel.deleteUser(id: item.id)
                                }
                            }
                            .foregroundColor(.red)
Spacer()
                            Button("Update") {
                                let updatedUser = UserMod(id: item.id, username: name, password: password)
                                Task {
                                    name = item.username
                                    password = item.password
                                    await viewModel.updateUser(updatedUser: updatedUser)
                                }
                            }
                            .foregroundColor(.blue)
                        }
                       // .font(.caption)
                    }
                }
            }
            VStack{
                TextField("username", text: $name)
                SecureField("enter your password", text: $password)
            }
            Button("Post New Item") {
                let newPost = UserMod(  id: UUID(), username: name, password: password)
                name = ""
                password = ""
                Task {
                    await viewModel.postNewItem(newPost: newPost)
                }
            }
            .padding()
        }
        .padding()
        .onAppear {
            Task {
                await viewModel.fetchRates()
            }
        }
    }
}

#Preview {
    PostApiView()
}
import Foundation
class PostApiJsonViewModel: ObservableObject {
    @Published var userInfo: [UserMod] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    func fetchRates() async {
        let baseURL = "https://cabd02a5882674dd675a.free.beeceptor.com/api/users/"
        guard let url = URL(string: baseURL) else { return }
        DispatchQueue.main.async {
            self.isLoading = true
        }
        defer {
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }
            let decodedData = try JSONDecoder().decode([UserMod].self, from: data)
            DispatchQueue.main.async {
                self.userInfo = decodedData
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = "Error: \(error.localizedDescription)"
            }
        }
    }
    func postNewItem(newPost: UserMod) async {
        let baseURL = "https://cabd02a5882674dd675a.free.beeceptor.com/api/users/"
        guard let url = URL(string: baseURL) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        do {
            let jsonData = try JSONEncoder().encode(newPost)
            request.httpBody = jsonData
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let (data, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse,
               (httpResponse.statusCode == 201 || httpResponse.statusCode == 200) {
                let decodedData = try JSONDecoder().decode(UserMod.self, from: data)
                DispatchQueue.main.async {
                    self.userInfo.append(decodedData)
                }
            } else {
                DispatchQueue.main.async {
                    self.errorMessage = "Server responded with error"
                }
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = "POST Error: \(error.localizedDescription)"
            }
        }
    }
    func updateUser(updatedUser: UserMod) async {
        let urlString = "https://cabd02a5882674dd675a.free.beeceptor.com/api/users/\(updatedUser.id)"
        guard let url = URL(string: urlString) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let jsonData = try JSONEncoder().encode(updatedUser)
            request.httpBody = jsonData

            let (data, response) = try await URLSession.shared.data(for: request)

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                let decodedUser = try JSONDecoder().decode(UserMod.self, from: data)
                DispatchQueue.main.async {
                    if let index = self.userInfo.firstIndex(where: { $0.id == decodedUser.id }) {
                        self.userInfo[index] = decodedUser
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.errorMessage = "Update failed with status code: \((response as? HTTPURLResponse)?.statusCode ?? 0)"
                }
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = "PUT Error: \(error.localizedDescription)"
            }
        }
    }
    func deleteUser(id: UUID) async {
        let urlString = "https://cabd02a5882674dd675a.free.beeceptor.com/api/users/\(id)"
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                DispatchQueue.main.async {
                    self.userInfo.removeAll { $0.id == id }
                }
            } else {
                DispatchQueue.main.async {
                    self.errorMessage = "Delete failed with status code: \((response as? HTTPURLResponse)?.statusCode ?? 0)"
                }
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = "DELETE Error: \(error.localizedDescription)"
            }
  struct UserMod: Codable,Identifiable {
    let id:UUID
    let username: String
    let password: String
}      }}}

import Foundation

let baseURL = "https://example.com/api/users"

// 1. GET
func getUser() {
    let url = URL(string: "\(baseURL)/1")!
    URLSession.shared.dataTask(with: url) { data, _, _ in
        if let data = data {
            print("GET: " + (String(data: data, encoding: .utf8) ?? ""))
        }
    }.resume()
}

// 2. POST
func createUser() {
    let url = URL(string: baseURL)!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    let newUser = ["name": "Podhu", "email": "podhu@example.com"]
    request.httpBody = try? JSONSerialization.data(withJSONObject: newUser)

    URLSession.shared.dataTask(with: request) { data, _, _ in
        if let data = data {
            print("POST: " + (String(data: data, encoding: .utf8) ?? ""))
        }
    }.resume()
}

// 3. PUT
func updateUserFull() {
    let url = URL(string: "\(baseURL)/1")!
    var request = URLRequest(url: url)
    request.httpMethod = "PUT"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    let updatedUser = ["name": "Full Updated", "email": "full@example.com"]
    request.httpBody = try? JSONSerialization.data(withJSONObject: updatedUser)

    URLSession.shared.dataTask(with: request) { data, _, _ in
        if let data = data {
            print("PUT: " + (String(data: data, encoding: .utf8) ?? ""))
        }
    }.resume()
}

// 4. PATCH
func updateUserPartial() {
    let url = URL(string: "\(baseURL)/1")!
    var request = URLRequest(url: url)
    request.httpMethod = "PATCH"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    let partialData = ["name": "Only Name"]
    request.httpBody = try? JSONSerialization.data(withJSONObject: partialData)

    URLSession.shared.dataTask(with: request) { data, _, _ in
        if let data = data {
            print("PATCH: " + (String(data: data, encoding: .utf8) ?? ""))
        }
    }.resume()
}

// 5. DELETE
func deleteUser() {
    let url = URL(string: "\(baseURL)/1")!
    var request = URLRequest(url: url)
    request.httpMethod = "DELETE"

    URLSession.shared.dataTask(with: request) { _, response, _ in
        if let httpRes = response as? HTTPURLResponse {
            print("DELETE: Status Code \(httpRes.statusCode)")
        }
    }.resume()
}

import Foundation

class APIService {
    
    func createPost(post: Post, completion: @escaping (Post?) -> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"                      // ✅ POST method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Encode Swift struct to JSON
        do {
            let jsonData = try JSONEncoder().encode(post)
            request.httpBody = jsonData
        } catch {
            print("Encoding Error:", error)
            completion(nil)
            return
        }
        
        // API Call
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let createdPost = try JSONDecoder().decode(Post.self, from: data)
                    completion(createdPost)
                } catch {
                    print("Decoding Error:", error)
                    completion(nil)
                }
            } else {
                print("Network Error:", error?.localizedDescription ?? "")
                completion(nil)
            }
        }.resume()
    }
}

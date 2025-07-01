import Foundation
class NewsAPICall {
    var newss: [News] = []
    func fetchNews(completion: @escaping ([News]) -> Void) {
        let url = URL(string: "https://newsapi.org/v2/everything?q=tesla&from=2025-05-29&sortBy=publishedAt&apiKey=33718be496b0450bbabf28aacf78bcd8")!

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }

            do {
                let decoded = try JSONDecoder().decode(NewsResponse.self, from: data)
                self.newss = decoded.articles
                                   DispatchQueue.main.async {
                                       completion((self.newss))
                                   }
            } catch {
                print("Decoding error: \(error)")
            }
        }.resume()
    }
    
        func news(at index: Int) -> News {
            return newss[index]
        }
    
        var count: Int {
            return newss.count
        }

}

import UIKit
// model structure
struct Organization: Codable {
    let login: String
    let url: String
    
}

class ViewController: UIViewController {
    var organizetions: [Organization] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchData()
       // print(organizetions)
    }

    func fetchData() {
        guard let url = URL(string: "https://api.github.com/users/hadley/orgs") else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error:", error)
                return
            }

            guard let data = data else { return }

            do {
                let decoder = JSONDecoder()
                self.organizetions = try decoder.decode([Organization].self, from: data)

                DispatchQueue.main.async {
                   // self.tableView.reloadData()
                    print(self.organizetions)
                }
            } catch {
                print("Decode error:", error)
            }
        }.resume()
    }
}


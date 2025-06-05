 }*/
import UIKit
import Alamofire
import SwiftLoader

struct Repository: Codable {
    let name: String
    let html_url: String
    let description: String?
    let fork: Bool
    let url: String
    let events_url: String
    let forks_url: String
    let owner: Owner

    func keyValuePairs() -> [(String, String)] {
        return [
            ("name", name),
            ("html_url", html_url),
            ("description", description ?? "N/A"),
            ("fork", fork ? "true" : "false"),
            ("url", url),
            ("events_url", events_url),
            ("forks_url", forks_url),
            ("owner", owner.login)
        ]
    }
}

struct Owner: Codable {
    let login: String
    let avatar_url: String
    let html_url: String
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tbl: UITableView!
    var repositories: [Repository] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Repositories"

        tbl.dataSource = self
        tbl.delegate = self
        tbl.register(UITableViewCell.self, forCellReuseIdentifier: "APITableCell")
        var config : SwiftLoader.Config = SwiftLoader.Config()
        config.size = 150
        config.spinnerColor = .white
        config.foregroundColor = .black
        config.backgroundColor = .clear

        SwiftLoader.setConfig(config)
        fetchData()
    }

    func fetchData() {
        let url = "https://api.github.com/users/hadley/repos"
        SwiftLoader.show(animated: true)
        AF.request(url).responseDecodable(of: [Repository].self) { response in
            switch response.result {
            case .success(let repos):
                self.repositories = repos
                SwiftLoader.hide()
                DispatchQueue.main.async {
                    self.tbl.reloadData()
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return repositories.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories[section].keyValuePairs().count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return repositories[section].name
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let repo = repositories[indexPath.section]
        let (key, value) = repo.keyValuePairs()[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "APITableCell", for: indexPath)
        cell.textLabel?.text = value.starts(with: "http") ? key.capitalized : "\(key.capitalized): \(value)"
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let repo = repositories[indexPath.section]
            let (key, value) = repo.keyValuePairs()[indexPath.row]

            tableView.deselectRow(at: indexPath, animated: true)

            if key == "owner" {
                let vc = OwnerCollectionViewController()
                vc.owner = repo.owner
                navigationController?.pushViewController(vc, animated: true)
            } else if value.starts(with: "http") {
                if let url = URL(string: value) {
                    UIApplication.shared.open(url)
                }
            
        }

    }
}

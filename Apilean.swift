import UIKit

struct Repository: Codable {
    let name: String
    let html_url: String
    let description: String?
    let fork: Bool
    let url: String
    let events_url: String
    let forks_url: String
    let owner: Owner
}

struct Owner: Codable {
    let login: String
    let avatar_url: String
    let html_url: String
}

class APITableCell:UITableViewCell{

        @IBOutlet weak var nameLabel: UILabel!
        @IBOutlet weak var languageLabel: UILabel!

        override func awakeFromNib() {
            super.awakeFromNib()
            //iconImageView.image = UIImage(systemName: "folder")
            //iconImageView.tintColor = .systemBlue
        }

        
            
}
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tbl: UITableView!

    var repositories: [Repository] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Organizations"
        tbl.dataSource = self
        tbl.delegate = self

        tbl.register(APITableCell.self, forCellReuseIdentifier: "APITableCell")

        //tbl.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        fetchData()
    }

    func fetchData() {
        guard let url = URL(string: "https://api.github.com/users/hadley/repos") else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error:", error)
                return
            }

            guard let data = data else { return }

            do {
                let decoder = JSONDecoder()
                self.repositories = try decoder.decode([Repository].self, from: data)

                DispatchQueue.main.async {
                    self.tbl.reloadData()
                }
            } catch {
                print("Decode error:", error)
            }
        }.resume()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return repositories.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories[section].keyValuePairs().count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "ID: \(repositories[section].id)"
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let org = repositories[indexPath.section]
        let (key, value) = org.keyValuePairs()[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "APITableCell", for: indexPath) as! APITableCell

        //let cell = tableView.dequeueReusableCell(withIdentifier: "APITableCell", for: indexPath) as! APITableCell
        
        if value.starts(with: "http") {
            cell.nameLabel?.text = key.capitalized // Show key only if value is a URL
            //cell.accessoryType = .disclosureIndicator
        } else {
            cell.nameLabel?.text = "\(key.capitalized): \(value)"
            //cell.accessoryType = .none
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let org = organizations[indexPath.section]
        let (key, value) = org.keyValuePairs()[indexPath.row]

        tableView.deselectRow(at: indexPath, animated: true)

        if key == "owner" {
            let vc = OwnerViewController()
            vc.owner = Owner(login: org.owner, avatar_url: org.avatar_url, html_url: org.repos_url) // OR properly create Owner from your actual data
            navigationController?.pushViewController(vc, animated: true)
            return
        }

        if value.starts(with: "http"), let url = URL(string: value) {
            if key == "avatar_url" {
                showImage(from: value)
            } else {
                UIApplication.shared.open(url)
            }
        }
    }


    func showImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }

        let vc = UIViewController()
        vc.view.backgroundColor = .white

        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.frame = vc.view.bounds
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        vc.view.addSubview(imageView)

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data, let image = UIImage(data: data) else { return }

            DispatchQueue.main.async {
                imageView.image = image
                self.present(vc, animated: true)
            }
        }.resume()
    }
}




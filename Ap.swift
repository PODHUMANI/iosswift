import UIKit

struct Organization: Codable {
    let id: Int
    let login: String
    let url: String
    let repos_url: String
    let events_url: String
    let avatar_url: String
    //let description: String?

    func keyValuePairs() -> [(String, String)] {
        return [
            ("login", login),
            ("url", url),
            ("repos_url", repos_url),
            ("events_url", events_url),
            ("avatar_url", avatar_url)
           // ("description", description ?? "")
        ]
    }
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let tableView = UITableView()
    var organizations: [Organization] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Organizations"
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        fetchData()
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
                self.organizations = try decoder.decode([Organization].self, from: data)

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("Decode error:", error)
            }
        }.resume()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return organizations.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return organizations[section].keyValuePairs().count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "ID: \(organizations[section].id)"
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let org = organizations[indexPath.section]
        let (key, value) = org.keyValuePairs()[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if value.starts(with: "http") {
            cell.textLabel?.text = key.capitalized // Show key only if value is a URL
            cell.accessoryType = .disclosureIndicator
        } else {
            cell.textLabel?.text = "\(key.capitalized): \(value)"
            cell.accessoryType = .none
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let org = organizations[indexPath.section]
        let (key, value) = org.keyValuePairs()[indexPath.row]

        guard value.starts(with: "http"), let url = URL(string: value) else {
            tableView.deselectRow(at: indexPath, animated: true)
            return
        }

        if key == "avatar_url" {
            showImage(from: value)
        } else {
            UIApplication.shared.open(url)
        }

        tableView.deselectRow(at: indexPath, animated: true)
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



import UIKit
import CollapsibleTableSectionViewController
struct Section {
    var name: String
    var items: [String]
    var collapsed: Bool

    init(name: String, items: [String], collapsed: Bool = true) {
        self.name = name
        self.items = items
        self.collapsed = collapsed
    }
}

class ViewController: CollapsibleTableSectionViewController , CollapsibleTableSectionDelegate  {

    var tableView: UITableView!

    var sections: [Section] = [
        Section(name: "Mac", items: ["MacBook", "MacBook Air"], collapsed: true),
        Section(name: "iPad", items: ["iPad Pro", "iPad Air 2"], collapsed: true),
        Section(name: "iPhone", items: ["iPhone 7", "iPhone 6"], collapsed: true)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView = UITableView(frame: view.bounds)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.allowsSelection = true
        view.addSubview(tableView)

        tableView.delegate = self
        tableView.dataSource = self
        self.delegate = self

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int) {
        sections[section].collapsed.toggle()
        tableView.reloadSections(IndexSet(integer: section), with: .automatic)
    }
    func numberOfSections(_ tableView: UITableView) -> Int {
        return sections.count
    }

    func collapsibleTableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].collapsed ? 0 : sections[section].items.count
    }

    func collapsibleTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("hai")

        let item = sections[indexPath.section].items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = item
        return cell
    }

    func collapsibleTableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].name
    }

    func collapsibleTableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedItem = sections[indexPath.section].items[indexPath.row]
                let alert = UIAlertController(title: "Selected Item", message: selectedItem, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                present(alert, animated: true)
//        if indexPath.row == 0 {
//            sections[indexPath.section] = sections[indexPath.section]
//
//                    tableView.reloadSections([indexPath.section], with: .automatic)
//                }
//
    }
    
    
}
//
//extension ViewController: CollapsibleTableSectionDelegate {
//
//   
//}


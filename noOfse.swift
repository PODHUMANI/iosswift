let sections = [
    ["Apple", "Avocado"],
    ["Banana", "Blueberry", "Blackberry"]
]

func numberOfSections(in tableView: UITableView) -> Int {
    return sections.count
}

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return sections[section].count
}

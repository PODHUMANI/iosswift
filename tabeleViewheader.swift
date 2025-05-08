 func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "FlowerHeaderTableViewCell") as? FlowerHeaderTableViewCell else {
            return nil
        }
        header.FlowerHeader.text = "🌸 Flower List"
        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .systemGray5

        let label = UILabel(frame: CGRect(x: 16, y: 5, width: tableView.frame.width - 32, height: 25))
        label.text = "Total flowers: \(name.count)"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 16)

        footerView.addSubview(label)
        return footerView
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40
    }
    
}

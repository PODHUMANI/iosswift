  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        
        performSegue(withIdentifier: "NextView", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NextView" {
            if let indexPath = selectedIndexPath {
                let receivedImage = image[indexPath.row] ?? UIImage(named: "defaultImage")
                let receivedName = name[indexPath.row]
                let receivedInfo = info[indexPath.row]
                
                let destinationVC = segue.destination as! NextViewController
                destinationVC.receivedImage = receivedImage
                destinationVC.receivedName = receivedName
                destinationVC.receivedInfo = receivedInfo
            }
        }

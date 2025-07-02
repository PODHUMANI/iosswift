import UIKit
class NewsTableViewCell: UITableViewCell {
    @IBOutlet var newsImageView: UIImageView!
    @IBOutlet weak var conteinerView: UIView!
    @IBOutlet var newsDescriptionLable: UILabel!
    @IBOutlet var newsTitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func configure(with news: News) {
        newsTitleLabel.text = news.title ?? "No Title"
            newsDescriptionLable.text = news.description ?? "No Description"
        if let imageUrl = news.urlToImage {
            loadImage(from: imageUrl)
        } else {
            newsImageView.image = UIImage(systemName: "photo")
        }
    }
 private func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }

        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    self.newsImageView.image = UIImage(data: data)
                }
            }
        }
    }
}

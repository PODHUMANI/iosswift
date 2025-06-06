import UIKit
import SDWebImage

class OwnerItemCell: UICollectionViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

        contentView.backgroundColor = .systemGray6
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.lightGray.cgColor

        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .label

        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
       // label.isHidden = false
    }

    
    func configure(text: String, isLink: Bool = false) {
        imageView.isHidden = true
       // label.isHidden = false
        label.text = text
        label.textColor = isLink ? .systemBlue : .label
    }

    func configureImage(from url: String) {
       // label.isHidden = true
        imageView.isHidden = false
        imageView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(systemName: "photo"))
    }
}

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var appleImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       // appleImage.image = UIImage(named: "appleImage")
        
        var myUrlImage = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTkl6UHcurrcZSKKzSHXri3SdOsJ-MdMNGkJw&s"
        
        DispatchQueue.global().async { [self] in
            let urltype = URL(string: myUrlImage)
            let data = try? Data(contentsOf: urltype!)
            DispatchQueue.main.async {
                self.appleImage.image = UIImage(data: data!)
            }
            
        }
        
        
    }
    
}

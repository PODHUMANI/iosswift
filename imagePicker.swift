import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var imageOne: UIImageView!
    @IBOutlet weak var imageTwo: UIImageView!
    @IBOutlet weak var imButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func imageButtionAction(_ sender: Any) {
        let imPicker = UIImagePickerController()
        imPicker.delegate = self
        imPicker.sourceType = .photoLibrary
        present(imPicker, animated : true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage]as?UIImage{
            if imageOne.image == nil{
                imageOne.image = selectedImage
            }else{
                imageTwo.image = selectedImage
            }
            dismiss(animated: true,completion: nil)
        }
        func imagePickerControllerDidCancel(_ imPicker: UIImagePickerController){
            dismiss(animated: true,completion: nil)
        }
        
    }
    
}

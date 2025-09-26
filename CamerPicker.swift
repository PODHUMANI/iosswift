import Foundation
import SwiftUI
struct CamerPicker: UIViewControllerRepresentable{
    @Environment(\.dismiss) var dismiss
    var action : (UIImage) -> Void
    func makeUIViewController(context : Context) -> some UIViewController {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .camera
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context){
        
    }
    func makeCoordinator() -> Coordinator{
        return Coordinator(self)
    }
   // func updateUIViewController(_ uiViewController: UIViewControllerType,context : Context){}
    class Coordinator: NSObject,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
        var parent:CamerPicker
        init(_ parent: CamerPicker) {
            self.parent = parent
        }
    
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController,didFinishPickingMadiawithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.editedImage] as? UIImage{
                parent.action(image)
            }
            parent.dismiss()
        }
    }
}

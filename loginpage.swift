

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!

    let aleltView = UIAlertController(title: "Error", message: "Some Message", preferredStyle: .alert)
    override func viewDidLoad() {
        super.viewDidLoad()
        // Additional setup if needed
        retrieveData();
        passwordTextField.placeholder = "●●●●●●●●●"
        passwordTextField.isSecureTextEntry = true
       
        let closeAction = UIAlertAction(title: "Close", style: .default){
            (action) in
            self.aleltView.dismiss(animated: true,completion: nil)
        }
        aleltView.addAction(closeAction)
    }
    func retrieveData(){
        let email = UserDefaults.standard.string(forKey: "email")
        let pass = UserDefaults.standard.string(forKey: "pass")

        if email != nil {
            emailTextField.text = email
        }
        if pass != nil{
            passwordTextField.text = pass
        }

    }
    @IBAction func loginButtonAction(_ sender: Any) {
        do {
            let email = emailTextField.text
            let password = passwordTextField.text
            try LoginHelper().login(email: email, password: password)

            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let tabVC = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as? UITabBarController {
                tabVC.modalPresentationStyle = .fullScreen
                self.present(tabVC, animated: true, completion: nil)
            }

        } catch let error as LoginError {
            aleltView.message = error.errorMessage
            self.present(aleltView, animated: true)
        } catch {
            // Handle any unexpected errors
            aleltView.message = "Something went wrong. Please try again."
            self.present(aleltView, animated: true)
        }
    }


    @IBAction func createAccoutButtonAc(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let nextVC = storyboard.instantiateViewController(withIdentifier: "SignupViewController") as? SignupViewController {
            nextVC.modalPresentationStyle = .fullScreen
            self.present(nextVC, animated: true, completion: nil)
        }
    }
   enum LoginError: Error{
        case emptyEmail
        case invalidEmail
        case emptyPassword
        case invalidPassword
        case invalidCredentials
        
        var errorMessage: String {
            switch self{
            case .emptyEmail:
                return "Email is Required"
            case .invalidEmail:
                return "Invalid Email"
            case .emptyPassword:
                return "Password is Required"
            case .invalidPassword:
                return "password should be more 5 character"
            case .invalidCredentials:
                return "invalid Credentials"
            }
        }
    }
    class LoginHelper{
        
        func login(email: String?, password: String?) throws {
           
            guard let email = email, !email.isEmpty else {
                throw LoginError.emptyEmail
            }
            guard email.contains("@") else {
                throw LoginError.invalidEmail
            }
            guard let password = password, !password.isEmpty else {
                throw LoginError.emptyPassword
            }
            guard password.count > 5 else {
                throw LoginError.invalidPassword
            }
            let Credentials = UserDefaults.standard.string(forKey: "email")
            if Credentials == nil || Credentials != email{
                throw LoginError.invalidCredentials
            }
            print("Login Successfully")
        }
        

    }
    
}

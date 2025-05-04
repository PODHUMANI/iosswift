 UserDefaults.standard.set(false, forKey: "isLoggedIn")
                      if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = scene.delegate as? SceneDelegate {
               
               let storyboard = UIStoryboard(name: "Main", bundle: nil)
               let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
              UIView.transition(with: sceneDelegate.window!,
                                 duration: 0.5,
                                 options: [.transitionFlipFromRight],
                                 animations: {
                                     sceneDelegate.window?.rootViewController = loginVC
                                 },
                                 completion: nil)

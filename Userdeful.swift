import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
       
       
            guard let windowScene = (scene as? UIWindowScene) else { return }
            window = UIWindow(windowScene: windowScene)
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
            
            if isLoggedIn {
                // User is already logged in → Show Home page
                let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
                window?.rootViewController = homeVC
            } else {
                // Not logged in → Show Login page
                let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
                window?.rootViewController = loginVC
            }
            
            window?.makeKeyAndVisible()
        
        
        
        //        guard let windowScene = (scene as? UIWindowScene) else { return }
        //        let islogin = UserDefaults.standard.bool(forKey: "isLoggedIn")
        //        if islogin == true{
        //            let storyboards = UIStoryboard(name: "Main", bundle: nil)
        //            let HomeViewController = storyboards.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        
        //  self.navigationController?.pushViewController(HomeViewController, animated: true)
        
        
        
        // performSegue(withIdentifier: "HomeScren", sender: self)
        /*let storyboard = UIStoryboard(name: "Main", bundle: nil)
         if let nextVC = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController {
         nextVC.modalPresentationStyle = .fullScreen
         self.present(nextVC, animated: true, completion: nil)
         }*/
   // }
//
//                self.window = UIWindow(windowScene: windowScene)
//                //self.window =  UIWindow(frame: UIScreen.main.bounds)
//
//                let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        guard let rootVC = storyboard.instantiateViewController(identifier: "LoginViewController") as? LoginViewController else {
//                    print("ViewController not found")
//                    return
//                }
//                let rootNC = UINavigationController(rootViewController: rootVC)
//                self.window?.rootViewController = rootNC
//                self.window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}


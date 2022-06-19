//
//  SceneDelegate.swift
//  LIttle Victories
//
//  Created by Tiffany Pan on 6/17/22.
//

import UIKit
import GoogleSignIn
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
//    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//        if let windowScene = scene as? UIWindowScene {
//            let window = UIWindow(windowScene: windowScene)
//            let WriteLittleVictoryVC = WriteLittleVictoryVC()
//            window.rootViewController = UINavigationController(rootViewController: WriteLittleVictoryVC)
//            self.window = window
//            window.makeKeyAndVisible()
//        }
//    }
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        
        // I used Firebase to set up GoogleAuthentication in this case. It is linked to my backend so that every time a user logs in, a new user is created on their end with the token that I send them.
        
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).


        // I used Firebase to set up GoogleAuthentication in this case. It is linked to my backend so that every time a user logs in, a new user is created on their end with the token that I send them.

        FirebaseApp.configure()

        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let signInConfig = GIDConfiguration(clientID: clientID)

        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        window.rootViewController = UINavigationController(rootViewController: GoogleAuthLoginVC())
        window.makeKeyAndVisible()

        // check if the user has previously signed in before, if so, let them pass. If not, direct them to log in page.
        guard GIDSignIn.sharedInstance.hasPreviousSignIn() else {
            window.rootViewController = UINavigationController(rootViewController: GoogleAuthLoginVC())
            return
        }

        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if let error = error {
                window.rootViewController = UINavigationController(rootViewController: GoogleAuthLoginVC())
                print(error.localizedDescription)
                return
            }

            guard let user = user else {
                window.rootViewController = UINavigationController(rootViewController: GoogleAuthLoginVC())
                return
            }

            let token = user.authentication.idToken
            // TODO - make networking request to login and pass token
            // done in the GoogleAuthLoginVC via a POST request
            window.rootViewController = UINavigationController(rootViewController: WriteLittleVictoryVC())
        }
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

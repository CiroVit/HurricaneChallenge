//
//  AppDelegate.swift
//  VideoCall
//
//  Created by Ciro Vitale on 05/05/2020.
//  Copyright © 2020 Ciro Vitale. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window : UIWindow?
    var activeController: UIViewController!
    var navigationController: UINavigationController!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        let SB = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        
        Auth.auth().addStateDidChangeListener { (_, user) in
            switch user {
            case nil:
                
                guard self.activeController! is TabBarViewController else {return}
                let NotLoggedIn = SB.instantiateViewController(identifier: "HomeHVC") as! ViewController
                self.navigationController.setViewControllers([NotLoggedIn], animated: false)
                self.navigationController.popToViewController(NotLoggedIn, animated: true)
                self.activeController = NotLoggedIn
                
            default:
                
                guard self.activeController! is ViewController else {return}
                let LoggedIn = SB.instantiateViewController(identifier: "ExhibitorHVC") as TabBarViewController
                self.navigationController.setViewControllers([LoggedIn], animated: false)
                self.navigationController.popToViewController(LoggedIn, animated: true)
                self.activeController = LoggedIn
                
            }
        }
        
        let notLoggedInController = SB.instantiateViewController(identifier: "HomeHVC") as! ViewController
        let loggedInController = SB.instantiateViewController(identifier: "ExhibitorHVC") as! TabBarViewController
        
        activeController = notLoggedInController
        
        switch Auth.auth().currentUser != nil {
        case true:
            activeController = loggedInController
        default:
            break
        }
        
        navigationController = UINavigationController.init(rootViewController: activeController)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        
        return true
    }

    // MARK: UISceneSession Lifecycle
    

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

}


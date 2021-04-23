//
//  AppDelegate.swift
//  6002CEM-8655295
//
//  Created by Bruna Coimbra on 16/03/2021.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        //Handles User authorization method
        
        //Auth.auth().addStateDidChangeListener { auth, user in
        //let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if Auth.auth().currentUser != nil {
            //Shows App
            
            print("User is logged In")
            window = UIWindow(frame: UIScreen.main.bounds)

            /*let controller = storyboard.instantiateViewController(identifier: "mainTabBarController") as! UITabBarController
            self.view.window!.rootViewController = controller
            self.view.window?.makeKeyAndVisible()*/
            
        } else {
            print("User is logged out")
            //Shows Initial View
            /*let controller = storyboard.instantiateViewController(identifier: "initialViewController") as! InitialViewController
            self.view.window!.rootViewController = controller
            self.view.window?.makeKeyAndVisible()*/
            
        }
        // Override point for customization after application launch.
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


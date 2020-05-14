//
//  AppDelegate.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 23.12.2019.
//  Copyright © 2019 Roman Khodukin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        
        print(UserDefaults.standard.isAuthorized)
        
        if UserDefaults.standard.isAuthorized {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarVC")
            let navController = UINavigationController(rootViewController: tabBarController)
            navController.isNavigationBarHidden = true
            window?.rootViewController = navController
            window?.makeKeyAndVisible()
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let authController = storyboard.instantiateViewController(withIdentifier: "VkAuthorizationViewController")
            let navController = UINavigationController(rootViewController: authController)
            navController.isNavigationBarHidden = true
            window?.rootViewController = navController
            window?.makeKeyAndVisible()
        }
        
        return true
    }
}


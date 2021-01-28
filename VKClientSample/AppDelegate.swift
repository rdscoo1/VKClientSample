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
        
        let vc = VkAuthorizationViewController()
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.navigationBar.backgroundColor = Constants.Colors.theme
        
        window = UIWindow()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        configureNavigationBar()
        
        return true
    }
    
    func configureNavigationBar() {
        UINavigationBar.appearance().barTintColor = Constants.Colors.theme
    }
}


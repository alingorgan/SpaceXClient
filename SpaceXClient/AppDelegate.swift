//
//  AppDelegate.swift
//  SpaceXClient
//
//  Created by Alin Gorgan on 5/27/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var router: Router = Router(
        storyboard: .init(name: "Main", bundle: .main),
        navigationController: .init())

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow()
        window.rootViewController = router.navigationController
        window.makeKeyAndVisible()
        self.window = window
        
        router.showMainScreen()
        
        return true
    }
}


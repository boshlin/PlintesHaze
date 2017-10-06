//
//  AppDelegate.swift
//  PurpleHaze
//
//  Created by Alexander Khodko on 11/09/2017.
//  Copyright © 2017 Alexander Khodko. All rights reserved.
//

import UIKit
import SWRevealViewController

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? 

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        UINavigationBar.appearance().tintColor = .yellowHook
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor.white,
        ]
        UIApplication.shared.statusBarStyle = .lightContent
        User.shared.isAuthorised = false
        if !User.shared.isAuthorised {
            let initialViewController = Storyboards.registration.instantiateViewController(withIdentifier: "InitialViewController")
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
            return true
        }
        let initialViewController = Storyboards.application.instantiateViewController(withIdentifier: "SWRevealViewController")
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
        return true
    }
}


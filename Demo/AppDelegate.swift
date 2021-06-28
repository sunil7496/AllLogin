//
//  AppDelegate.swift
//  Demo
//
//  Created by TrivialWorks on 10/10/19.
//  Copyright © 2019 TrivialWorks. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import GoogleSignIn
import Firebase
import TwitterKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
//        ApplicationDelegate.shared.application(
//            application,
//            didFinishLaunchingWithOptions: launchOptions
//        )
        
        GIDSignIn.sharedInstance().clientID = "1027219592811-jtl2651qcgsd7bfr804crsoqj6v6622q.apps.googleusercontent.com"
        TWTRTwitter.sharedInstance().start(withConsumerKey:"qRbilEhK0kiF25rekMNaKgfDb", consumerSecret:"tuARnKDgOqbcgCEytAH0gWVoLyo8b4nDgC0mLgWW6VYg5G4xAK")
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        
        return true
    }

    func application(_ app: UIApplication,open url: URL,options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let facebookLogin = ApplicationDelegate.shared.application(app,open: url,options: options)
        let twitterLogin =  TWTRTwitter.sharedInstance().application(app, open: url, options: options)
        let googleLogin = (GIDSignIn.sharedInstance()?.handle(url ))!
        return facebookLogin || twitterLogin || googleLogin
    }
        
//    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool
//    {
//        return (GIDSignIn.sharedInstance()?.handle(url ))!
//    }

    func applicationWillResignActive(_ application: UIApplication)
    {
        AppEvents.activateApp()
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool
    {
        return ApplicationDelegate.shared.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    func application(_ application: UIApplication, shouldAllowExtensionPointIdentifier extensionPointIdentifier: UIApplication.ExtensionPointIdentifier) -> Bool
    {
        if (extensionPointIdentifier == UIApplication.ExtensionPointIdentifier.keyboard)
        {
            return false
        }
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        print("configurationForConnecting")
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
        print("didDiscardSceneSessions")
    }


}


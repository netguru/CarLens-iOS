//
//  ApplicationDelegate.swift
//  CarRecognition
//

import UIKit

@UIApplicationMain
internal final class ApplicationDelegate: UIResponder, UIApplicationDelegate {

    /// - SeeAlso: UIApplicationDelegate.window
    lazy var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window?.rootViewController = UIViewController()
        window?.makeKeyAndVisible()
        
        return true
    }
}

//
//  ApplicationDelegate.swift
//  CarLens
//

import UIKit

@UIApplicationMain
final class ApplicationDelegate: UIResponder, UIApplicationDelegate {

    /// Shared dependencies used extensively in the application
    private let applicationDependencies = ApplicationDependencies()

    /// Main Flow controller of the app
    private lazy var flowController = ApplicationFlowController(window: window, dependencies: applicationDependencies)

    /// - SeeAlso: UIApplicationDelegate.window
    lazy var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)

    func application(_ application: UIApplication,
                     willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        applicationDependencies.crashLogger.start()
        return true
    }

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        flowController.startApp()
        return true
    }
}

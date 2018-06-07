//
//  ApplicationFlowController.swift
//  CarRecognition
//


import UIKit

/// Main Flow controller of the app, has access to the main window and can change root controller
internal final class ApplicationFlowController {
    
    private weak var window: UIWindow?
    
    private let dependencies: ApplicationDependencies
    
    /// Initializes Main Flow Controllers
    ///
    /// - Parameters:
    ///   - window: Main window of the app
    ///   - dependencies: Deppendencies to use in the app
    init(window: UIWindow?, dependencies: ApplicationDependencies) {
        guard let window = window else {
            fatalError("Window given to the App Flow Controller was nil")
        }
        self.window = window
        self.dependencies = dependencies
    }
    
    /// Call after application was loaded, it will set proper view controller as window root
    internal func startApp() {
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        window?.rootViewController = LiveVideoViewController(viewMaker: LiveVideoView())
    }
}

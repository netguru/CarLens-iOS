//
//  ApplicationFlowController.swift
//  CarLens
//


import UIKit

/// Main Flow controller of the app, has access to the main window and can change root controller
internal final class ApplicationFlowController {
    
    private weak var window: UIWindow?
    
    private var rootFlowController: FlowController?
    
    private let dependencies: ApplicationDependencies
    
    private let applicationFactory: ApplicationFactory
    
    private let userDefaultsService: UserDefaultsService
    /// Initializes Main Flow Controllers
    ///
    /// - Parameters:
    ///   - window: Main window of the app
    ///   - dependencies: Deppendencies to use in the app
    init(window: UIWindow?, dependencies: ApplicationDependencies, userDefaultsService: UserDefaultsService = UserDefaultsService.shared) {
        guard let window = window else {
            fatalError("Window given to the App Flow Controller was nil")
        }
        self.window = window
        self.dependencies = dependencies
        applicationFactory = ApplicationFactory(applicationDependencies: dependencies)
        self.userDefaultsService = userDefaultsService
    }
    
    /// Call after application was loaded, it will set proper view controller as window root
    func startApp() {
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        if userDefaultsService.shouldShowOnboarding {
            changeRootFlowController(to: makeOnboardingFlowController())
        } else {
            changeRootFlowController(to: makeRecognitionFlowController())
        }
    }
    
    private func makeOnboardingFlowController() -> FlowController {
        return OnboardingFlowController(dependencies: dependencies, applicationFactory: applicationFactory)
    }
    
    private func makeRecognitionFlowController() -> FlowController {
        return RecognitionFlowController(dependencies: dependencies, applicationFactory: applicationFactory)
    }
    
    private func changeRootFlowController(to flowController: FlowController) {
        rootFlowController = flowController
        window?.rootViewController = flowController.rootViewController
    }
}

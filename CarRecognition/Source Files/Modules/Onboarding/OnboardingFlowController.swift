//
//  OnboardingFlowController.swift
//  CarRecognition
//


import UIKit

internal final class OnboardingFlowController: FlowController {
    /// Root view controler of the flow
    private(set) var rootViewController = UIViewController()
    
    private let dependencies: ApplicationDependencies
    
    private let applicationFactory: ApplicationFactory
    
    /// Initializes flow controllers with given dependencies
    ///
    /// - Parameters:
    ///   - dependencies: Dependencies to use in the class
    ///   - applicationFactory: Factory used to create controller with injected dependencies
    init(dependencies: ApplicationDependencies, applicationFactory: ApplicationFactory) {
        self.dependencies = dependencies
        self.applicationFactory = applicationFactory
        rootViewController = makeOnboardingViewController()
    }
    
    private func makeOnboardingViewController() -> UIViewController {
        let viewController = applicationFactory.onboardingViewController()
        viewController.eventTriggered = { [unowned self] event in
            switch event {
            case .didTriggerFinishOnboarding:
                let recognitionFlowController = self.makeRecognitionFlowController()
                let recognitionController = recognitionFlowController.rootViewController
                viewController.present(recognitionController, animated: false, completion: nil)
            }
        }
        return viewController
    }
    
    private func makeRecognitionFlowController() -> FlowController {
        return RecognitionFlowController(dependencies: dependencies, applicationFactory: applicationFactory)
    }
}

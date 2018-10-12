//
//  OnboardingFlowController.swift
//  CarRecognition
//


import UIKit

internal final class OnboardingFlowController: FlowController {
    
    /// Root view controler of the flow
    private(set) var rootViewController = UIViewController()
    
    /// Next Flow Controller to which user should be transitioned from this view
    private(set) var nextFlowController: FlowController?
    
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
        let viewController = ModelsViewController(viewMaker: ModelsView())
        viewController.eventTriggered = { [unowned self] model in
            self.nextFlowController = self.makeRecognitionFlowController(with: model)
            let recognitionController = self.nextFlowController?.rootViewController
            viewController.present(recognitionController!, animated: false, completion: nil)
        }
        return viewController
//        let viewController = applicationFactory.onboardingViewController()
//        viewController.eventTriggered = { [unowned self] event in
//            switch event {
//            case .didTriggerFinishOnboarding:
//                self.nextFlowController = self.makeRecognitionFlowController()
//                let recognitionController = self.nextFlowController?.rootViewController
//                viewController.present(recognitionController!, animated: false, completion: nil)
//            }
//        }
//        return viewController
    }
    
        private func makeRecognitionFlowController(with model: TestingModel) -> FlowController {
            return RecognitionFlowController(dependencies: dependencies, applicationFactory: applicationFactory, with: model)
    }
}

//
//  RecognitionFlowController.swift
//  CarRecognition
//


import UIKit

internal final class RecognitionFlowController: FlowController {
    
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
        rootViewController = makeRecognitionViewController()
    }
    
    /// Root view controler of the flow
    private(set) var rootViewController = UIViewController()
    
    private func makeRecognitionViewController() -> RecognitionViewController {
        let viewController = applicationFactory.recognitionViewController()
        viewController.eventTriggered = { [unowned self] event in
            switch event {
            case .didTriggerShowCarsList(let car):
                viewController.present(self.makeCarsListViewController(with: car), animated: true)
            case .didTriggerGoogleSearch(let car):
                SearchService().search(.google, for: car)
            }
        }
        return viewController
    }
    
    private func makeCarsListViewController(with scannedCar: Car?) -> CarsListViewController {
        let viewController = applicationFactory.carsListViewController(with: scannedCar)
        viewController.eventTriggered = { [unowned viewController, self] event in
            switch event {
            case .didTapDismiss:
                guard let recognitionViewController = self.rootViewController as? RecognitionViewController else { return }
                recognitionViewController.removeSlidingCard()
                viewController.dismiss(animated: true)
            case .didTapBackButton:
                viewController.dismiss(animated: true)
            }
        }
        return viewController
    }
}

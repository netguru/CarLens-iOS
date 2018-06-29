//
//  RecognitionFlowController.swift
//  CarRecognition
//


import UIKit

internal final class RecognitionFlowController: FlowController {
    
    private let dependencies: ApplicationDependencies
    
    /// Initializes flow controllers with given dependencies
    ///
    /// - Parameters:
    ///   - dependencies: Dependencies to use in the class
    init(dependencies: ApplicationDependencies) {
        self.dependencies = dependencies
        rootViewController = makeRecognitionViewController()
    }
    
    /// Root view controler of the flow
    private(set) var rootViewController = UIViewController()
    
    private func makeRecognitionViewController() -> RecognitionViewController {
        let viewController = dependencies.applicationFactory.recognitionViewController()
        viewController.eventTriggered = { event in
            switch event {
            case .didTapSelectModel:
                // TODO: Open controller with available models
                break
            }
        }
        return viewController
    }
}

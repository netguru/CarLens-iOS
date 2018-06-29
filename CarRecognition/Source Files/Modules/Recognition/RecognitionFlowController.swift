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

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
        rootViewController = UINavigationController(rootViewController: makeRecognitionViewController())
    }
    
    /// Root view controler of the flow
    private(set) var rootViewController = UIViewController()
    
    /// Root view controller casted as navigation controller
    var navigationController: UINavigationController? {
        return rootViewController as? UINavigationController
    }
    
    private func makeRecognitionViewController() -> RecognitionViewController {
        let viewController = dependencies.applicationFactory.recognitionViewController()
//        viewController.viewModel.eventTriggered = { [unowned self] event in
//            switch event {
//            case .userLoggedIn:
//                self.eventTriggered?(.userLoggedIn)
//            case .didTapRegister:
//                self.navigationController?.pushViewController(self.makeRegisterViewController(), animated: true)
//            }
//        }
//        return viewController
        return viewController
    }
}

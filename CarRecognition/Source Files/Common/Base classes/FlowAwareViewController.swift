//
//  FlowAwareViewController.swift
//  CarRecognition
//


import UIKit

/// Simple View controller class with helper callbacks for flow management
internal class FlowAwareViewController: KeyboardAwareViewController {
    
    /// Closure triggered when view controller will be popped from navigation stack
    var willMoveToParentViewController: ((UIViewController?) -> ())?
    
    /// Closure triggered when view controller has been popped from navigation stack
    var onMovingFromParentViewController: (() -> ())?
    
    /// Closure triggered when view controller has been pushed into navigation stack
    var onMovingToParentViewController: (() -> ())?
    
    /// - SeeAlso: UIViewController.viewWillAppear()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let navigationBarCustomizable = self as? NavigationBarSetupable, let navigationController = navigationController {
            navigationBarCustomizable.setup(navigationBar: navigationController.navigationBar)
        }
        if isMovingToParentViewController {
            onMovingToParentViewController?()
        }
    }
    
    /// - SeeAlso: UIViewController.viewWillDisappear()
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParentViewController {
            onMovingFromParentViewController?()
        }
    }
    
    /// - SeeAlso: UIViewController.willMove()
    override func willMove(toParentViewController parent: UIViewController?) {
        super.willMove(toParentViewController: parent)
        willMoveToParentViewController?(parent)
        
        // Fix for the glitch when NavigationBar not changed it's style to the end of the pop animation
        guard
            let navigationController = navigationController,
            let controllerIndex = navigationController.viewControllers.index(of: self),
            controllerIndex > 0,
            let previousController = navigationController.viewControllers[controllerIndex-1] as? NavigationBarSetupable
        else { return }
        previousController.setup(navigationBar: navigationController.navigationBar)
    }
}

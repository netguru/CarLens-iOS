//
//  UIViewControllerExtension.swift
//  CarRecognition
//


import UIKit.UIViewController

internal extension UIViewController {
    
    /// Adds view controller as a child (calls all required methods automatically)
    ///
    /// - Parameters:
    ///   - child: Controller to be added as child
    ///   - container: Container to which child should be added
    func add(_ child: UIViewController, inside container: UIView) {
        addChildViewController(child)
        container.addSubview(child.view)
        child.didMove(toParentViewController: self)
        child.view.translatesAutoresizingMaskIntoConstraints = false
        child.view.constraintToSuperviewEdges()
    }
    
    /// Removes view controller from parent if added as child (calls all required methods automatically)
    func remove() {
        guard parent != nil else {
            return
        }
        willMove(toParentViewController: nil)
        removeFromParentViewController()
        view.removeFromSuperview()
    }
}

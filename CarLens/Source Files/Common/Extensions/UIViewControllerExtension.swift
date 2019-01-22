//
//  UIViewControllerExtension.swift
//  CarLens
//


import UIKit.UIViewController

extension UIViewController {

    /// Adds view controller as a child (calls all required methods automatically)
    ///
    /// - Parameters:
    ///   - child: Controller to be added as child
    ///   - container: Container to which child should be added
    func add(_ child: UIViewController, inside container: UIView) {
        addChild(child)
        container.addSubview(child.view)
        child.didMove(toParent: self)
        child.view.translatesAutoresizingMaskIntoConstraints = false
        child.view.constraintToSuperviewEdges()
    }

    /// Removes view controller from parent if added as child (calls all required methods automatically)
    func remove() {
        guard parent != nil else {
            return
        }
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
}

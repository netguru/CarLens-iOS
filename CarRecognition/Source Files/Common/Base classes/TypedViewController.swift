//
//  TypedViewController.swift
//  CarRecognition
//


import UIKit

/// Base class for view controllers with programatically created `View`
internal class TypedViewController<View: UIView>: FlowAwareViewController {
    
    /// Custom View
    let customView: View
    
    /// Initializes view controller with given View Model
    ///
    /// - Parameter viewMaker: Maker for the UIView
    init(viewMaker: @escaping @autoclosure () -> View) {
        self.customView = viewMaker()
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// - SeeAlso: UIViewController.loadView()
    override func loadView() {
        view = customView
        view.clipsToBounds = true
    }
}

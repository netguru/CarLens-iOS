//
//  FlowController.swift
//  CarRecognition
//


import UIKit.UIViewController

/// Interface for the flow controller
internal protocol FlowController {
    
    /// Root view controller of the given flow
    var rootViewController: UIViewController { get }
}

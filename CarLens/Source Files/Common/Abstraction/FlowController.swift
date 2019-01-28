//
//  FlowController.swift
//  CarLens
//


import UIKit.UIViewController

/// Interface for the flow controller
protocol FlowController {

    /// Root view controller of the given flow
    var rootViewController: UIViewController { get }
}

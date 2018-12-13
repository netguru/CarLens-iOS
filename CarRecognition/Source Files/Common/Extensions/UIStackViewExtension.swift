//
//  UIStackViewExtension.swift
//  CarRecognition
//


import UIKit

internal extension UIStackView {
    
    /// Convenience maker for the UIStackView
    ///
    /// - Parameters:
    ///   - axis: Axis of the stack view
    ///   - views: View that should be embeded into the stack view
    ///   - spacing: Spacing of the stack view (0 by default)
    /// - Returns: Created stack view
    static func make(axis: NSLayoutConstraint.Axis, with views: [UIView], spacing: CGFloat = 0, distribution: UIStackView.Distribution = .fill) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = axis
        stackView.spacing = spacing
        stackView.distribution = distribution
        return stackView.layoutable()
    }
}

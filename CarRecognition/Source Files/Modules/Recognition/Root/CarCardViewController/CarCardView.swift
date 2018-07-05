//
//  CarCardView.swift
//  CarRecognition
//


import UIKit

internal final class CarCardView: View, ViewSetupable {

    /// Main container of the view
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 14.0
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        return view.layoutable()
    }()

    /// - SeeAlso: ViewSetupable
    func setupViewHierarchy() {
        [containerView].forEach(addSubview)
    }

    /// - SeeAlso: ViewSetupable
    func setupConstraints() {
        containerView.constraintToSuperviewEdges()
    }
}

//
//  CarCardView.swift
//  CarRecognition
//


import UIKit

internal final class CarCardView: View, ViewSetupable {

    private lazy var containerView: UIView = {
        let view = UIView()

        view.backgroundColor = .white
        view.layer.cornerRadius = 14.0
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]

        return view.layoutable()
    }()

    func setupViewHierarchy() {
        [containerView].forEach(addSubview)
    }

    func setupConstraints() {
        containerView.constraintToSuperviewEdges()
    }
}

//
//  ModelNameView.swift
//  CarRecognition
//

import UIKit

/// Empty separator view, mainly for UIStackView
internal final class ModelNameView: View, ViewSetupable {
    
    /// Car that name should be displayed
    private let car: Car
    
    init(car: Car) {
        self.car = car
        super.init()
    }

    lazy var stackView: UIStackView = {
        let stackView = UIStackView.make(axis: .vertical, with: [modelLabel, brandLabel], spacing: -2)
        modelLabel.text = car.model
        brandLabel.text = car.brand
        return stackView
    }()
    
    let modelLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.gliscorGothicFont(ofSize: 30.0)
        label.textColor = .crFontDark
        return label.layoutable()
    }()
    
    let brandLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.gliscorGothicFont(ofSize: 25.0)
        label.textColor = .crFontGray
        return label.layoutable()
    }()

    func setupViewHierarchy() {
        addSubview(stackView)
    }

    func setupConstraints() {
        stackView.constraintToSuperviewEdges()
    }
}

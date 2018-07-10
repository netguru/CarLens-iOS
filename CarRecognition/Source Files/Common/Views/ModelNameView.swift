//
//  ModelNameView.swift
//  CarRecognition
//

import UIKit

internal final class ModelNameView: View, ViewSetupable {
    
    /// Car object used to initlaize labels
    private let car: Car

    /// StackView with model and brand labels
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView.make(axis: .vertical, with: [modelLabel, brandLabel], spacing: -2)
        modelLabel.text = car.model
        brandLabel.text = car.brand
        return stackView
    }()

    /// Model label
    private let modelLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32.0, weight: .bold)
        label.textColor = .crFontDark
        return label.layoutable()
    }()

    /// Brand label
    private let brandLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18.0)
        label.textColor = .crFontGray
        label.clipsToBounds = false
        return label.layoutable()
    }()
    
    /// Initializes the model view with given car parameter
    ///
    /// - Parameter car: Car instance used to instantiate labels
    init(car: Car) {
        self.car = car
        super.init()
    }

    /// - SeeAlso: ViewSetupable
    func setupViewHierarchy() {
        addSubview(stackView)
    }

    /// - SeeAlso: ViewSetupable
    func setupConstraints() {
        stackView.constraintToSuperviewEdges()
    }
}

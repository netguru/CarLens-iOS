//
//  RecognitionView.swift
//  CarRecognition
//


import UIKit
import ARKit

internal final class RecognitionView: View, ViewSetupable {

    /// Container for augmented reality view controller content
    lazy var augmentedRealityContainer = UIView().layoutable()
    
    /// First label with analyzed car model
    lazy var modelFirstLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 26)
        view.numberOfLines = 0
        view.textAlignment = .center
        return view
    }()
    
    /// Second label with analyzed car model
    lazy var modelSecondLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 22)
        view.numberOfLines = 0
        view.textAlignment = .center
        return view
    }()
    
    /// Third label with analyzed car model
    lazy var modelThirdLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 18)
        view.numberOfLines = 0
        view.textAlignment = .center
        return view
    }()
    
    /// Label with time interval of last analyze
    lazy var analyzeTimeLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14)
        view.numberOfLines = 0
        view.textAlignment = .center
        return view.layoutable()
    }()
    
    /// Button for checking details of detected car
    lazy var checkDetailsButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Check details", for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 18)
        return view.layoutable()
    }()
    
    private lazy var modelStackView = UIStackView.make(
        axis: .vertical,
        with: [
            modelFirstLabel,
            modelSecondLabel,
            modelThirdLabel,
            .separator(axis: .vertical, thickness: 5),
            checkDetailsButton
        ],
        spacing: 15
    ).layoutable()
    
    /// - SeeAlso: ViewSetupable
    func setupViewHierarchy() {
        [augmentedRealityContainer, modelStackView, analyzeTimeLabel].forEach(addSubview)
    }
    
    /// - SeeAlso: ViewSetupable
    func setupConstraints() {
        augmentedRealityContainer.constraintToSuperviewEdges(excludingAnchors: [.bottom])
        modelStackView.constraintToSuperviewEdges(excludingAnchors: [.top, .bottom], withInsets: .init(top: 16, left: 8, bottom: 16, right: 8))
        analyzeTimeLabel.constraintToSuperviewEdges(excludingAnchors: [.top])
        NSLayoutConstraint.activate([
            augmentedRealityContainer.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1),
            augmentedRealityContainer.bottomAnchor.constraint(equalTo: modelStackView.topAnchor)
        ])
    }
}

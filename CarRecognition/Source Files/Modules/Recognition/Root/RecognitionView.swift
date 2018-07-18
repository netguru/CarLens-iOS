//
//  RecognitionView.swift
//  CarRecognition
//


import UIKit
import ARKit

internal enum RecognitionViewMode {
    case basic
    case withCard
    case afterCardRemoval
    case view
}

internal final class RecognitionView: View, ViewSetupable {

    /// Container for augmented reality view controller content
    lazy var augmentedRealityContainer = UIView().layoutable()
    
    /// Cars list button in the left bottom corner
    lazy var carsListButton: UIButton = {
        let view = UIButton(type: .system)
        view.setImage(#imageLiteral(resourceName: "button-car-list-gray"), for: .normal)
        return view.layoutable()
    }()
    
    /// Cars list button in the left bottom corner
    lazy var closeButton: UIButton = {
        let view = UIButton(type: .system)
        view.setImage(#imageLiteral(resourceName: "button-close"), for: .normal)
        return view.layoutable()
    }()
    
    /// Cars recognisition button in the center of the bottom part of the view
    lazy var scanButton: UIButton = {
        let view = UIButton(type: .system)
        view.setImage(#imageLiteral(resourceName: "button-scan-primary"), for: .normal)
        return view.layoutable()
    }()
    
    /// Label with analyzed car model
    lazy var detectedModelLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 18)
        view.textColor = .white
        view.numberOfLines = 0
        view.textAlignment = .center
        return view
    }()
    
    /// Label with time interval of last analyze
    lazy var analyzeTimeLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14)
        view.textColor = .white
        view.numberOfLines = 0
        view.textAlignment = .center
        return view
    }()
    
    private lazy var modelStackView = UIStackView.make(
        axis: .vertical,
        with: [
            detectedModelLabel,
            analyzeTimeLabel
        ],
        spacing: 5
    ).layoutable()
    
    var mode: RecognitionViewMode = .basic {
        didSet {
            switch mode {
            case .basic:
                closeButton.isHidden = true
                modelStackView.isHidden = false
                scanButton.isHidden = true
            case .withCard:
                closeButton.isHidden = true
                modelStackView.isHidden = true
                scanButton.isHidden = true
            case .afterCardRemoval:
                closeButton.isHidden = false
                modelStackView.isHidden = false
                scanButton.isHidden = true
            case .view:
                closeButton.isHidden = true
                modelStackView.isHidden = true
                scanButton.isHidden = false
            }
        }
    }
    
    /// - SeeAlso: ViewSetupable
    func setupViewHierarchy() {
        [augmentedRealityContainer, modelStackView, carsListButton, closeButton, scanButton].forEach(addSubview)
    }
    
    /// - SeeAlso: ViewSetupable
    func setupConstraints() {
        augmentedRealityContainer.constraintToSuperviewEdges()
        carsListButton.constraintToConstant(.init(width: 45, height: 45))
        modelStackView.constraintToSuperviewEdges(excludingAnchors: [.top], withInsets: .init(top: 0, left: 8, bottom: 8, right: 8))
        NSLayoutConstraint.activate([
            carsListButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            carsListButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            closeButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
            scanButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8),
            scanButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0)
        ])
    }
    
    /// - SeeAlso: ViewSetupable
    func setupProperties() {
        mode = .basic
    }
}

//
//  RecognitionView.swift
//  CarRecognition
//


import UIKit
import ARKit

/// Enum describing types of mode that view can have.
///
/// - basic: Basic regonsition mode.
/// - withCard: Recognition mode with card pn a view.
/// - afterCardRemoval: Recognition mode after card was removed.
/// - explore: Exploration mode of AR world. No active recognition.
internal enum RecognitionViewMode {
    case basic
    case withCard
    case afterCardRemoval
    case explore
}

internal final class RecognitionView: View, ViewSetupable {

    /// Container for augmented reality view controller content
    lazy var augmentedRealityContainer = UIView().layoutable()
    
    /// Cars list button in the left bottom corner
    lazy var carsListButton: UIButton = {
        let view = UIButton(type: .system)
        view.setImage(#imageLiteral(resourceName: "button-car-list-gray"), for: .normal)
        view.accessibilityIdentifier = "recognition/button/cars"
        return view.layoutable()
    }()
    
    /// Close list button in the right bottom corner
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
                closeButton.alpha = 0
                #if !ENV_RELEASE
                modelStackView.alpha = 1
                #endif
                scanButton.alpha = 0
            case .withCard:
                closeButton.alpha = 0
                modelStackView.alpha = 0
                scanButton.alpha = 0
            case .afterCardRemoval:
                closeButton.alpha = 1
                #if !ENV_RELEASE
                modelStackView.alpha = 1
                #endif
                scanButton.alpha = 0
            case .explore:
                closeButton.alpha = 0
                modelStackView.alpha = 0
                scanButton.alpha = 1
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
        #if ENV_RELEASE
            modelStackView.isHidden = true
        #endif
    }
}

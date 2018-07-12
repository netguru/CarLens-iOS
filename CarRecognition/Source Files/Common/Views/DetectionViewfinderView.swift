//
//  DetectionViewfinderView.swift
//  CarRecognition
//


import UIKit
import Lottie

internal final class DetectionViewfinderView: View, ViewSetupable {
    
    /// Error that can occur durning updating state
    enum DetectionViewfinderViewError: Error {
        case wrongValueProvided
    }
    
    private lazy var viewfinderAnimationView = LOTAnimationView(name: "viewfinder_bracket").layoutable()
    
    private lazy var informationLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 16, weight: .semibold)
        view.textColor = .white
        view.numberOfLines = 1
        view.textAlignment = .center
        view.text = Localizable.Recognition.pointCameraAtCar
        return view.layoutable()
    }()
    
    /// Updates the detection state
    ///
    /// - Parameter result: Result of the detection
    func update(to result: RecognitionResult, normalizedConfidence: Double) {
        viewfinderAnimationView.animationProgress = CGFloat(normalizedConfidence)
        guard normalizedConfidence > 0.1 else {
            informationLabel.text = Localizable.Recognition.pointCameraAtCar
            return
        }
        informationLabel.text = Localizable.Recognition.recognizing
    }
    
    /// - SeeAlso: ViewSetupable
    func setupViewHierarchy() {
        [viewfinderAnimationView, informationLabel].forEach(addSubview)
    }
    
    /// - SeeAlso: ViewSetupable
    func setupConstraints() {
        viewfinderAnimationView.constraintToSuperviewEdges(excludingAnchors: [.bottom])
        NSLayoutConstraint.activate([
            viewfinderAnimationView.bottomAnchor.constraint(equalTo: informationLabel.topAnchor, constant: 30),
            informationLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            informationLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}

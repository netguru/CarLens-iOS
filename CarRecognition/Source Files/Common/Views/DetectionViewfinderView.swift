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
    
    private lazy var informationSwitcherView = TextSwitcherView(currentText: Localizable.Recognition.pointCameraAtCar).layoutable()
    
    /// Updates the detection state
    ///
    /// - Parameters:
    ///     - result: Result of the detection
    ///     - normalizedConfidence: Normalized confidence of the model
    func update(to result: RecognitionResult, normalizedConfidence: Double) {
        viewfinderAnimationView.animationProgress = CGFloat(normalizedConfidence)
        guard normalizedConfidence > 0.5 else {
            informationSwitcherView.switchLabelsWithText(Localizable.Recognition.pointCameraAtCar)
            return
        }
        let text: String
        switch result.recognition {
        case .car(_):
            text = Localizable.Recognition.recognizing
        case .otherCar:
            text = Localizable.Recognition.otherCar
        case .notCar:
            text = Localizable.Recognition.pointCameraAtCar
        }
        informationSwitcherView.switchLabelsWithText(text)
    }
    
    /// - SeeAlso: ViewSetupable
    func setupViewHierarchy() {
        [viewfinderAnimationView, informationSwitcherView].forEach(addSubview)
    }
    
    /// - SeeAlso: ViewSetupable
    func setupConstraints() {
        viewfinderAnimationView.constraintToSuperviewEdges(excludingAnchors: [.bottom])
        informationSwitcherView.constraintToSuperviewEdges(excludingAnchors: [.top], withInsets: .init(top: 0, left: 8, bottom: 0, right: 8))
        NSLayoutConstraint.activate([
            viewfinderAnimationView.bottomAnchor.constraint(equalTo: informationSwitcherView.topAnchor, constant: 60),
            informationSwitcherView.centerXAnchor.constraint(equalTo: centerXAnchor),
            informationSwitcherView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
}

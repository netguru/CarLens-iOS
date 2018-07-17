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
    /// - Parameter result: Result of the detection
    func update(to result: RecognitionResult, normalizedConfidence: Double) {
        viewfinderAnimationView.animationProgress = CGFloat(normalizedConfidence)
        guard normalizedConfidence > 0.1 else {
            informationSwitcherView.switchLabelsWithText(Localizable.Recognition.pointCameraAtCar)
            return
        }
        informationSwitcherView.switchLabelsWithText(Localizable.Recognition.recognizing)
    }
    
    /// - SeeAlso: ViewSetupable
    func setupViewHierarchy() {
        [viewfinderAnimationView, informationSwitcherView].forEach(addSubview)
    }
    
    /// - SeeAlso: ViewSetupable
    func setupConstraints() {
        viewfinderAnimationView.constraintToSuperviewEdges(excludingAnchors: [.bottom])
        informationSwitcherView.constraintToSuperviewEdges(excludingAnchors: [.top], withInsets: .init(top: 0, left: 0, bottom: 0, right: 0))
        NSLayoutConstraint.activate([
            viewfinderAnimationView.bottomAnchor.constraint(equalTo: informationSwitcherView.topAnchor, constant: 30),
            informationSwitcherView.centerXAnchor.constraint(equalTo: centerXAnchor),
            informationSwitcherView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

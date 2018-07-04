//
//  DetectionViewfinderView.swift
//  CarRecognition
//


import UIKit
import Lottie

internal final class DetectionViewfinderView: View, ViewSetupable {
    
    /// Available state supported by the view
    enum State {
        case recognizing(progress: Double)
        case recognized(car: Car)
    }
    
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
        view.text = Localizable.Recognition.putCarInCenter
        return view.layoutable()
    }()
    
    /// Updates the detection state
    ///
    /// - Parameter state: State of the detection
    func update(state: State) throws {
        switch state {
        case .recognizing(let progress):
            guard progress >= 0 && progress <= 1 else {
                throw DetectionViewfinderViewError.wrongValueProvided
            }
            viewfinderAnimationView.animationProgress = CGFloat(progress)
            if progress < 0.1 {
                informationLabel.text = Localizable.Recognition.putCarInCenter
            } else {
                informationLabel.text = Localizable.Recognition.recognizing
            }
        case .recognized(let car):
            guard case Car.other = car else { return }
            informationLabel.text = Localizable.Recognition.carNotSupported
        }
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

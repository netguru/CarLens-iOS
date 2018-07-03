//
//  DetectionViewfinderView.swift
//  CarRecognition
//


import UIKit
import Lottie

internal final class DetectionViewfinderView: View, ViewSetupable {
    
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
        view.text = "Put car in the center"
        return view.layoutable()
    }()
    
    /// Updates the detection progress
    ///
    /// - Parameter progress: Progress of the detection. Must be value between 0 and 1
    func update(progress: CGFloat) throws {
        guard progress >= 0 && progress <= 1 else {
            throw DetectionViewfinderViewError.wrongValueProvided
        }
        viewfinderAnimationView.animationProgress = progress
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

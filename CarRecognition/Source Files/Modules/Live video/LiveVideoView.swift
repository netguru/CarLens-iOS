//
//  LiveVideoView.swift
//  CarRecognition
//


import UIKit
import ARKit

internal final class LiveVideoView: View, ViewSetupable {

    /// View with camera preview
    lazy var previewView: ARSKView = {
        let view = ARSKView()
        view.presentScene(sceneView)
        return view.layoutable()
    }()
    
    /// Augmented Reality scene presented on the camera preview
    lazy var sceneView = SKScene()
    
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
        [previewView, modelStackView, analyzeTimeLabel].forEach(addSubview)
    }
    
    /// - SeeAlso: ViewSetupable
    func setupConstraints() {
        previewView.constraintToSuperviewEdges(excludingAnchors: [.bottom])
        modelStackView.constraintToSuperviewEdges(excludingAnchors: [.top, .bottom], withInsets: .init(top: 16, left: 8, bottom: 16, right: 8))
        analyzeTimeLabel.constraintToSuperviewEdges(excludingAnchors: [.top])
        NSLayoutConstraint.activate([
            previewView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1),
            previewView.bottomAnchor.constraint(equalTo: modelStackView.topAnchor)
        ])
    }
}

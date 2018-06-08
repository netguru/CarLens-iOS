//
//  LiveVideoView.swift
//  CarRecognition
//


import UIKit
import ARKit
import SpriteKit

internal final class LiveVideoView: View, ViewSetupable {

    /// Augmented Reality scene view
    lazy var previewView: UIView = {
        let view = UIView()
        return view.layoutable()
    }()
    
    /// Label with analyed car model
    lazy var modelLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 26)
        view.numberOfLines = 0
        view.textAlignment = .center
        return view.layoutable()
    }()
    
    /// Label with time interval of last analyze
    lazy var analyzeTimeLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14)
        view.numberOfLines = 0
        view.textAlignment = .center
        return view.layoutable()
    }()
    
    /// - SeeAlso: ViewSetupable
    func setupViewHierarchy() {
        [previewView, modelLabel, analyzeTimeLabel].forEach(addSubview)
    }
    
    /// - SeeAlso: ViewSetupable
    func setupConstraints() {
        previewView.constraintToSuperviewEdges(excludingAnchors: [.bottom])
        modelLabel.constraintToSuperviewEdges(excludingAnchors: [.top])
        analyzeTimeLabel.constraintToSuperviewEdges(excludingAnchors: [.top])
        NSLayoutConstraint.activate([
            previewView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1),
            previewView.bottomAnchor.constraint(equalTo: modelLabel.topAnchor)
        ])
    }
}

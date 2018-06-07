//
//  LiveVideoView.swift
//  CarRecognition
//


import UIKit
import ARKit
import SpriteKit

internal final class LiveVideoView: View, ViewSetupable {

    /// Augmented Reality scene view
    lazy var sceneView: ARSKView = {
        let view = ARSKView()
        return view.layoutable()
    }()
    
    /// SpriteKit 3D scene view
    lazy var overlayScene: SKScene = {
        let overlayScene = SKScene()
        overlayScene.scaleMode = .aspectFill
        return overlayScene
    }()
    
    /// Augmented Reality scene view
    lazy var modelLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 26)
        view.numberOfLines = 0
        view.textAlignment = .center
        return view.layoutable()
    }()
    
    /// - SeeAlso: ViewSetupable
    func setupViewHierarchy() {
        addSubview(sceneView)
        addSubview(modelLabel)
        sceneView.presentScene(overlayScene)
    }
    
    /// - SeeAlso: ViewSetupable
    func setupConstraints() {
        sceneView.constraintToSuperviewEdges(excludingAnchors: [.bottom])
        modelLabel.constraintToSuperviewEdges(excludingAnchors: [.top])
        NSLayoutConstraint.activate([
            sceneView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1),
            sceneView.bottomAnchor.constraint(equalTo: modelLabel.topAnchor)
        ])
    }
}

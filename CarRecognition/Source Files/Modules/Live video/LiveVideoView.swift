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
    
    /// - SeeAlso: ViewSetupable
    func setupViewHierarchy() {
        addSubview(sceneView)
        sceneView.presentScene(overlayScene)
    }
    
    /// - SeeAlso: ViewSetupable
    func setupConstraints() {
        sceneView.constraintToSuperviewEdges()
    }
}

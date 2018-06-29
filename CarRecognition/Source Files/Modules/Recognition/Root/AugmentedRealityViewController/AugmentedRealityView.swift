//
//  AugmentedRealityView.swift
//  CarRecognition
//


import UIKit
import ARKit

internal final class AugmentedRealityView: View, ViewSetupable {
    
    /// View with camera preview
    lazy var previewView: ARSKView = {
        let view = ARSKView()
        view.presentScene(sceneView)
        return view.layoutable()
    }()
    
    /// Augmented Reality scene presented on the camera preview
    lazy var sceneView = SKScene()
    
    /// - SeeAlso: ViewSetupable
    func setupViewHierarchy() {
        addSubview(previewView)
    }
    
    /// - SeeAlso: ViewSetupable
    func setupConstraints() {
        previewView.constraintToSuperviewEdges()
    }
}

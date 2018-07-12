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
    lazy var sceneView = CarScene()
    
    /// View with animated bracket showing detection progress
    lazy var detectionViewfinderView = DetectionViewfinderView().layoutable()
    
    private lazy var dimmView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return view.layoutable()
    }()
    
    /// - SeeAlso: ViewSetupable
    func setupViewHierarchy() {
        [previewView, dimmView, detectionViewfinderView].forEach(addSubview)
    }
    
    /// - SeeAlso: ViewSetupable
    func setupConstraints() {
        dimmView.constraintToSuperviewEdges()
        previewView.constraintToSuperviewEdges()
        detectionViewfinderView.constraintCenterToSuperview(withConstant: .init(x: 0, y: -50))
    }
    
    /// - SeeAlso: ViewSetupable
    func setupProperties() {
        [dimmView, detectionViewfinderView].forEach { $0.isUserInteractionEnabled = false }
    }
}

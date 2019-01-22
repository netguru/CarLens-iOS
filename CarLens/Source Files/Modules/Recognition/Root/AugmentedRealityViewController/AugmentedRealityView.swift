//
//  AugmentedRealityView.swift
//  CarLens
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

    /// Blur effect view presented when camera is not ready to show content
    internal let blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let view = UIVisualEffectView(effect: blurEffect)
        return view.layoutable()
    }()

    /// Augmented Reality scene presented on the camera preview
    lazy var sceneView = CarScene()

    /// View with animated bracket showing detection progress
    lazy var detectionViewfinderView = DetectionViewfinderView().layoutable()

    /// Dimming black view covering whole camera screen
    lazy var dimmView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return view.layoutable()
    }()

    /// - SeeAlso: ViewSetupable
    func setupViewHierarchy() {
        [previewView, dimmView, detectionViewfinderView, blurEffectView].forEach(addSubview)
    }

    /// - SeeAlso: ViewSetupable
    func setupConstraints() {
        dimmView.constraintToSuperviewEdges()
        previewView.constraintToSuperviewEdges()
        detectionViewfinderView.constraintCenterToSuperview(withConstant: .init(x: 0, y: -50))
        blurEffectView.constraintToSuperviewEdges()
    }

    /// - SeeAlso: ViewSetupable
    func setupProperties() {
        [dimmView, detectionViewfinderView].forEach { $0.isUserInteractionEnabled = false }
    }
}

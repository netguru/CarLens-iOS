//
//  DetectionViewfinderView.swift
//  CarRecognition
//


import UIKit
import Lottie

internal final class DetectionViewfinderView: View, ViewSetupable {
    
    private lazy var viewfinderAnimationView = LOTAnimationView(name: "viewfinder_bracket").layoutable()
    
    /// Updates the detection progress
    ///
    /// - Parameter progress: Progress of the detection. Must be value between 0 and 1
    func update(progress: CGFloat) {
        guard progress >= 0 && progress <= 1 else {
            fatalError("Progress must be between 0 and 1")
        }
        viewfinderAnimationView.animationProgress = progress
    }
    
    /// - SeeAlso: ViewSetupable
    func setupViewHierarchy() {
        addSubview(viewfinderAnimationView)
    }
    
    /// - SeeAlso: ViewSetupable
    func setupConstraints() {
        viewfinderAnimationView.constraintToSuperviewEdges()
    }
    
    /// - SeeAlso: ViewSetupable
    func setupProperties() {
        viewfinderAnimationView.loopAnimation = true
        viewfinderAnimationView.play(fromProgress: 0, toProgress: 1.5, withCompletion: nil)
    }
}

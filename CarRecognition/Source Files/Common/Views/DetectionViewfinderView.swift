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
        addSubview(viewfinderAnimationView)
    }
    
    /// - SeeAlso: ViewSetupable
    func setupConstraints() {
        viewfinderAnimationView.constraintToSuperviewEdges()
    }
}

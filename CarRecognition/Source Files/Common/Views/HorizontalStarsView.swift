//
//  HorizontalStarsView.swift
//  CarRecognition
//


import UIKit
import Lottie

internal final class HorizontalStarsView: View, ViewSetupable {
    
    private lazy var animationView = LOTAnimationView(name: "horizontal-stars").layoutable()
    
    /// - SeeAlso: ViewSetupable
    func setupViewHierarchy() {
        addSubview(animationView)
    }
    
    /// - SeeAlso: ViewSetupable
    func setupConstraints() {
        animationView.constraintToSuperviewEdges()
    }
    
    /// - SeeAlso: ViewSetupable
    func setupProperties() {
        animationView.loopAnimation = true
        animationView.play(toProgress: 1.0, withCompletion: nil)
    }
}

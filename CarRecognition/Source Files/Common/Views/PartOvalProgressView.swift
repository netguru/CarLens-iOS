//
//  PartOvalProgressView.swift
//  CarRecognition
//


import UIKit
import Lottie

internal final class PartOvalProgressView: View, ViewSetupable {
    
    private lazy var animationView = LOTAnimationView(name: "part_oval_progress").layoutable()
    
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

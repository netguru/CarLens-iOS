//
//  FullOvalProgressView.swift
//  CarRecognition
//


import UIKit
import Lottie

internal final class FullOvalProgressView: View, ViewSetupable {
    
    private lazy var animationView = LOTAnimationView(name: "full_oval_progress").layoutable()
    
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
        
        // TODO: For debuging purposes. Remove when lottie will be fully working
        animationView.clipsToBounds = false
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
    }
}

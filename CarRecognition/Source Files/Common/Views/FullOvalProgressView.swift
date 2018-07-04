//
//  FullOvalProgressView.swift
//  CarRecognition
//


import UIKit
import Lottie

internal final class FullOvalProgressView: View, ViewSetupable {
    
    private lazy var animationView = LOTAnimationView(name: "full_oval_progress").layoutable()
    
    private lazy var valueLabel: UILabel = {
        let view = UILabel()
        view.font = .gliscorGothicFont(ofSize: 20)
        view.textColor = .crFontDark
        view.numberOfLines = 1
        view.textAlignment = .center
        return view.layoutable()
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = .gliscorGothicFont(ofSize: 14)
        view.textColor = .crFontGray
        view.numberOfLines = 1
        view.textAlignment = .center
        return view.layoutable()
    }()
    
    /// - SeeAlso: ViewSetupable
    func setupViewHierarchy() {
        [animationView, valueLabel, titleLabel].forEach(addSubview)
    }
    
    /// - SeeAlso: ViewSetupable
    func setupConstraints() {
        animationView.constraintToSuperviewEdges(withInsets: .init(top: 0, left: 0, bottom: 20, right: 8))
        valueLabel.constraintToSuperviewEdges(excludingAnchors: [.top, .bottom], withInsets: .init(top: 0, left: 8, bottom: 0, right: 8))
        titleLabel.constraintToSuperviewEdges(excludingAnchors: [.top], withInsets: .init(top: 0, left: 8, bottom: 4, right: 8))
        NSLayoutConstraint.activate([
            valueLabel.centerYAnchor.constraint(equalTo: animationView.centerYAnchor),
        ])
    }
    
    /// - SeeAlso: ViewSetupable
    func setupProperties() {
        animationView.clipsToBounds = false
        animationView.loopAnimation = true
        animationView.play(toProgress: 1.0, withCompletion: nil)
        
        valueLabel.text = "94 mph"
        titleLabel.text = "TOP SPEED"
        backgroundColor = .gray
    }
}

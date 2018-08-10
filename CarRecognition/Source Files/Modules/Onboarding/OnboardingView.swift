//
//  OnboardingView.swift
//  CarRecognition
//


import UIKit
import Lottie

internal final class OnboardingView: View, ViewSetupable  {
    
    lazy var nextButton: UIButton = {
        let view = UIButton(type: .system)
        view.setImage(#imageLiteral(resourceName: "button-scan-primary"), for: .normal)
        return view.layoutable()
    }()
    
    lazy var indicatorAnimationView = LOTAnimationView(name: "indicator-onboarding").layoutable()
    
    lazy var pageView = UIView().layoutable()
    
    // MARK: - Setup
    func setupViewHierarchy() {
        [pageView, nextButton, indicatorAnimationView].forEach { addSubview($0) }
    }
    
    func setupProperties() { }
    
    func setupConstraints() {
        nextButton.constraintCenterToSuperview(axis: [.horizontal])
        pageView.constraintToSuperviewEdges(excludingAnchors: [.bottom])
        
        indicatorAnimationView.constraintCenterToSuperview(axis: [.horizontal])
        
        NSLayoutConstraint.activate([
            nextButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            pageView.bottomAnchor.constraint(equalTo: nextButton.topAnchor),
            indicatorAnimationView.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -20)
        ])
    }
    
}

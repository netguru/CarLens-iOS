//
//  OnboardingView.swift
//  CarRecognition
//


import UIKit

internal final class OnboardingView: View, ViewSetupable  {
    
    lazy var nextButton: UIButton = {
        let view = UIButton(type: .system)
        view.setImage(#imageLiteral(resourceName: "button-next-page"), for: .normal)
        return view.layoutable()
    }()
    
    lazy var pageView = UIView().layoutable()
    
    // MARK: - Setup
    func setupViewHierarchy() {
        [pageView, nextButton].forEach { addSubview($0) }
    }
    
    func setupConstraints() {
        nextButton.constraintCenterToSuperview(axis: [.horizontal])
        pageView.constraintToSuperviewEdges(excludingAnchors: [.bottom])
        
        NSLayoutConstraint.activate([
            nextButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            pageView.bottomAnchor.constraint(equalTo: nextButton.topAnchor)
        ])
    }
    
}

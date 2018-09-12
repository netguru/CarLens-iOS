//
//  OnboardingView.swift
//  CarRecognition
//


import UIKit

internal final class OnboardingView: View, ViewSetupable  {
    /// Animation View which is responsible for showing the onboarding animation.
    lazy var animationView = UIView().layoutable()
    
    /// Page View with onboarding screens.
    lazy var pageView = UIView().layoutable()
    
    /// Button indicating a possibility of moving to the next page.
    lazy var nextButton: UIButton = {
        let view = UIButton(type: .system)
        view.accessibilityIdentifier = "onboarding/button/next"
        view.setImage(#imageLiteral(resourceName: "button-next-page"), for: .normal)
        return view.layoutable()
    }()
    
    lazy var pageControl: UIPageControl = {
        let view = UIPageControl().layoutable()
        view.currentPageIndicatorTintColor = UIColor.crOnboardingDeepOrange
        view.pageIndicatorTintColor = UIColor.crOnboardingLightOrange
        view.currentPage = 0
        view.numberOfPages = 3
        return view
    }()
    
    // MARK: - Setup
    func setupViewHierarchy() {
        [animationView, pageView, pageControl, nextButton].forEach { addSubview($0) }
    }
    
    func setupConstraints() {
        pageView.constraintToSuperviewEdges(excludingAnchors: [.top, .bottom])
        
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            animationView.centerXAnchor.constraint(equalTo: centerXAnchor),
            animationView.widthAnchor.constraint(equalTo: animationView.heightAnchor, multiplier: 636/720),
            animationView.bottomAnchor.constraint(equalTo: pageView.topAnchor, constant: 4),
            pageView.heightAnchor.constraint(equalToConstant: 125),
            pageView.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -14),
            pageControl.widthAnchor.constraint(equalToConstant: 150),
            pageControl.heightAnchor.constraint(equalToConstant: 40),
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -24),
            nextButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: 100),
            nextButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -18)
        ])
    }
    
    func setupProperties() {
        backgroundColor = UIColor.crBackgroundGray
    }
}

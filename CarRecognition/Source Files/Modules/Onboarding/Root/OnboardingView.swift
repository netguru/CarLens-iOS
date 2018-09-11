//
//  OnboardingView.swift
//  CarRecognition
//


import UIKit

internal final class OnboardingView: View, ViewSetupable  {
    
    lazy var animatedView = UIView().layoutable()
    
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
        [animatedView, pageView, pageControl, nextButton].forEach { addSubview($0) }
    }
    
    func setupConstraints() {
//        animatedView.constraintToSuperviewEdges(excludingAnchors: [.top, .bottom])
        pageView.constraintToSuperviewEdges(excludingAnchors: [.top, .bottom])
        
        NSLayoutConstraint.activate([
            animatedView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.45),
            animatedView.centerXAnchor.constraint(equalTo: centerXAnchor),
            animatedView.widthAnchor.constraint(equalTo: animatedView.heightAnchor, multiplier: 636/720),
//            animatedView.heightAnchor.constraint(equalTo: animatedView.widthAnchor, multiplier: 720/636),
            animatedView.bottomAnchor.constraint(equalTo: pageView.topAnchor, constant: 4),
//            pageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2),
            pageView.heightAnchor.constraint(equalToConstant: 150),
//            pageView.topAnchor.constraint(equalTo: animatedView.bottomAnchor, constant: 4),
            pageView.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -20),
            pageControl.widthAnchor.constraint(equalToConstant: 150),
            pageControl.heightAnchor.constraint(equalToConstant: 40),
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -20),
            nextButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: 100),
            nextButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
        ])
    }
    
    func setupProperties() {
        backgroundColor = UIColor.crBackgroundGray
    }
}

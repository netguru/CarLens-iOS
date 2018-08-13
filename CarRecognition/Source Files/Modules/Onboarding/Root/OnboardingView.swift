//
//  OnboardingView.swift
//  CarRecognition
//


import UIKit

internal final class OnboardingView: View, ViewSetupable  {
    /// Page View with onboarding screens.
    lazy var pageView = UIView().layoutable()
    
    /// Button indicating a possibility of moving to the next page.
    lazy var nextButton: UIButton = {
        let view = UIButton(type: .system)
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
        [pageView, pageControl, nextButton].forEach { addSubview($0) }
    }
    
    func setupConstraints() {
        pageView.constraintToSuperviewEdges(excludingAnchors: [.bottom])
        
        NSLayoutConstraint.activate([
            pageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8),
            pageControl.topAnchor.constraint(equalTo: pageView.bottomAnchor, constant: 4),
            pageControl.widthAnchor.constraint(equalToConstant: 150),
            pageControl.heightAnchor.constraint(equalToConstant: 20),
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            nextButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            nextButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
        ])
    }
    
    func setupProperties() {
        backgroundColor = UIColor.crBackgroundGray
    }
}

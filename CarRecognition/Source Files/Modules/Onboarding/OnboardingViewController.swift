//
//  OnboardningViewController.swift
//  CarRecognition
//


import UIKit

internal final class OnboardingViewController: TypedViewController<OnboardingView> {
    
    /// Page View Controller used for onboarding views
    lazy var pageViewController: OnboardingPageViewController = {
        let viewController = OnboardingPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [:])
        return viewController
    }()
    
    override func loadView() {
        super.loadView()
        
        add(pageViewController, inside: customView.pageView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.nextButton.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
    }
    
    @objc private func didTapNext() {
        pageViewController.moveToNextPage()
    }
}

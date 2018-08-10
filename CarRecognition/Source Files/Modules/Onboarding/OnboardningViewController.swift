//
//  OnboardningViewController.swift
//  CarRecognition
//


import UIKit

internal final class OnboardingViewController: TypedViewController<OnboardingView> {

    lazy var pageViewController: OnboardingPageViewController = {
        return OnboardingPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [:])
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

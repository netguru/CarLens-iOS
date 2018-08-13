//
//  OnboardningViewController.swift
//  CarRecognition
//


import UIKit

internal final class OnboardingViewController: TypedViewController<OnboardingView> {
    /// Enum describing events that can be triggered by this controller
    ///
    /// - didTriggerFinishOnboarding: Send when user is on the last screen of onboarding and triggers the "next" button.
    enum Event {
        case didTriggerFinishOnboarding
    }
    
    /// Callback with triggered event
    var eventTriggered: ((Event) -> ())?
    
    /// Page View Controller used for onboarding views
    private lazy var pageViewController: OnboardingPageViewController = {
        let viewController = OnboardingPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [:])
        viewController.onboardingDelegate = self
        return viewController
    }()
    
    override func loadView() {
        super.loadView()
        add(pageViewController, inside: customView.pageView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.accessibilityIdentifier = "onboarding/view/main"
        customView.nextButton.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        pageViewController.onChangePage = { [weak self] page in
            self?.customView.pageControl.currentPage = page
        }
    }
    
    @objc private func didTapNext() {
        pageViewController.moveToNextPage()
    }
}

extension OnboardingViewController: OnboardingPageViewControllerDelegate {
    func didFinishOnboarding(onboardingPageViewController: OnboardingPageViewController) {
        eventTriggered?(.didTriggerFinishOnboarding)
    }
}

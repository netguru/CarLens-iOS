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
    
    /// Callback with triggered event.
    var eventTriggered: ((Event) -> ())?
    
    /// Page View Controller used for onboarding views.
    private lazy var pageViewController: OnboardingPageViewController = {
        let viewController = OnboardingPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [:])
        viewController.onboardingDelegate = self
        return viewController
    }()
    
    /// Animation Player handling animation by animation player view controller.
    private lazy var animationPlayer = OnboardingAnimationPlayer()
    
    override func loadView() {
        super.loadView()
        addChildViewControllers()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    private func addChildViewControllers() {
        add(pageViewController, inside: customView.pageView)
        add(animationPlayer.playerViewController, inside: customView.animatedView)
    }
    
    private func setUpView() {
        view.accessibilityIdentifier = "onboarding/view/main"
        customView.nextButton.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        customView.animatedView.addGestureRecognizer(panGesture)
    }
    
     @objc private func handleSwipe(_ sender:UIPanGestureRecognizer) {
        if sender.direction == .rightToLeft {
            guard sender.state == .ended else { return }
            let swipeLocation = sender.translation(in: customView)
            guard abs(swipeLocation.x) > customView.frame.size.width/2 else { return }
            pageViewController.moveToNextPage()
        }
        if sender.direction == .leftToRight {
            guard sender.state == .ended else { return }
            let swipeLocation = sender.translation(in: customView)
            guard swipeLocation.x > customView.frame.size.width/2 else { return }
//            pageViewController.moveToNextPage()
        }
    }
    @objc private func didTapNext() {
        pageViewController.moveToNextPage()
    }
}

extension OnboardingViewController: OnboardingPageViewControllerDelegate {
    
    func onboardingPageViewController(_ onboardingPageViewController: OnboardingPageViewController, willTransitionFrom currentPageIndex: Int, to nextPageIndex: Int) {
        let lastPageIndex = onboardingPageViewController.numberOfPages - 1
        if nextPageIndex == lastPageIndex {
            customView.nextButton.setImage(#imageLiteral(resourceName: "button-scan-with-shadow"), for: .normal)
        } else if currentPageIndex == lastPageIndex {
            customView.nextButton.setImage(#imageLiteral(resourceName: "button-next-page"), for: .normal)
        }
        customView.pageControl.currentPage = nextPageIndex
        animationPlayer.animate(fromPage: currentPageIndex, to: nextPageIndex)
    }
    
    func didFinishOnboarding(onboardingPageViewController: OnboardingPageViewController) {
        eventTriggered?(.didTriggerFinishOnboarding)
    }
}

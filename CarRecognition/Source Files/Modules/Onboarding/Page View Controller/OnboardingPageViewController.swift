//
//  OnboardingPageViewController.swift
//  CarRecognition
//


import UIKit

/// The delegate of OnboardingPageViewController.
protocol OnboardingPageViewControllerDelegate: class {
    
    /// Called when user wants to change a page via swipe gesture or by tapping next button.
    ///
    /// - Parameters:
    /// - onboardingPageViewController: The View Controller from which the delegate was called.
    /// - currentPageIndex: Page on which user is currently now.
    /// - nextPageIndex: Next page to which user wants to transition.
    func onboardingPageViewController(_ onboardingPageViewController: OnboardingPageViewController, willTransitionFrom currentPageIndex: Int, to nextPageIndex: Int)
    
    /// Called when user finished last onboarding screen.
    /// - Parameter onboardingPageViewController: The View Controller from which the delegate was called.
    func didFinishOnboarding(onboardingPageViewController: OnboardingPageViewController)
}

internal final class OnboardingPageViewController: UIPageViewController {
    
    /// Page View Delegate used to inform about onboarding being finished
    weak var onboardingDelegate: OnboardingPageViewControllerDelegate?
    
    /// Current page index.
    private var currentIndex = 0
    
    /// Content onboarding views used inside Page View
    private lazy var contentViewControllers = [
        OnboardingContentViewController(type: .first),
        OnboardingContentViewController(type: .second),
        OnboardingContentViewController(type: .third)
    ]
    
    /// Number of content onboarding view controllers used inside Page View.
    lazy var numberOfPages = contentViewControllers.count
    
    /// Animation Player handling animation by animation player view controller.
    private lazy var animationPlayer = OnboardingAnimationPlayer()
    
    /// - SeeAlso: UIPageViewController
    override init(transitionStyle style: UIPageViewControllerTransitionStyle, navigationOrientation: UIPageViewControllerNavigationOrientation, options: [String : Any]? = nil) {
        super.init(transitionStyle: style, navigationOrientation: navigationOrientation, options: options)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPageViewController()
    }
    
    /// The method indicating that the user wants to move to the next page.
    func moveToNextPage() {
        guard currentIndex != contentViewControllers.endIndex - 1 else {
            onboardingDelegate?.didFinishOnboarding(onboardingPageViewController: self)
            return
        }
        update(toPage: currentIndex + 1)
        setViewControllers([contentViewControllers[currentIndex]], direction: .forward, animated: true, completion: nil)
    }
    
    private func setupPageViewController() {
        for viewController in contentViewControllers {
            viewController.delegate = self
        }
        setViewControllers([contentViewControllers[0]], direction: .forward, animated: false, completion: nil)
        dataSource = self
    }
    
    private func update(toPage nextPage: Int) {
        contentViewControllers[nextPage].animate(fromPage: currentIndex)
        onboardingDelegate?.onboardingPageViewController(self, willTransitionFrom: currentIndex, to: nextPage)
        currentIndex = nextPage
    }
}

// MARK: - UIPageViewControllerDataSource
extension OnboardingPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard  let contentViewController = viewController as? OnboardingContentViewController,
            let index = contentViewControllers.index(of: contentViewController) else { return nil }
        let previousIndex = index - 1
        guard contentViewControllers.count > previousIndex, previousIndex >= 0 else { return nil }
        return contentViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let contentViewController = viewController as? OnboardingContentViewController,
            let index = contentViewControllers.index(of: contentViewController) else { return nil }
        let nextIndex = index + 1
        guard contentViewControllers.count != nextIndex, contentViewControllers.count > nextIndex else { return nil }
        return contentViewControllers[nextIndex]
    }
}

// MARK: - OnboardingContentPresentable
extension OnboardingPageViewController: OnboardingContentPresentable {
    
    func willPresentControllerWithType(_ type: OnboardingContentViewController.ContentType) {
        if (currentIndex == 0 && type.rawValue == 0) {
            contentViewControllers[currentIndex].animate(fromPage: currentIndex)
        } else {
            guard currentIndex != type.rawValue else { return }
            update(toPage: type.rawValue)
        }
    }
}

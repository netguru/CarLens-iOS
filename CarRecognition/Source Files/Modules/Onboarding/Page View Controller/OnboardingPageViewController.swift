//
//  OnboardingPageViewController.swift
//  CarRecognition
//


import UIKit

/// The delegate of OnboardingPageViewController.
protocol OnboardingPageViewControllerDelegate: class {
    /// Called when user finished last onboarding screen.
    /// - Parameter onboardingPageViewController: The View Controller from which the delegate was called.
    func didFinishOnboarding(onboardingPageViewController: OnboardingPageViewController)
}

internal final class OnboardingPageViewController: UIPageViewController {
    /// Page View Delegated used to inform about onboarding being finished
    weak var onboardingDelegate: OnboardingPageViewControllerDelegate?
    /// Current page index.
    private var currentIndex = 0 {
        didSet {
            onChangePage?(currentIndex)
        }
    }
    
    typealias Page = Int
    /// Variable which gets called on the changing of pages
    var onChangePage: ((Page) -> Void)?
    
    /// Content onboarding views used inside Page View
    private lazy var contentViewControllers = [
        OnboardingContentViewController(type: .recognizeCars),
        OnboardingContentViewController(type: .second),
        OnboardingContentViewController(type: .third)
    ]
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
        currentIndex += 1
        setViewControllers([contentViewControllers[currentIndex]], direction: .forward, animated: true, completion: nil)
    }
    
    private func setupPageViewController() {
        for viewController in contentViewControllers {
            viewController.delegate = self
        }
        setViewControllers([contentViewControllers[0]], direction: .forward, animated: false, completion: nil)
        dataSource = self
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
    func didPresentControllerWithType(_ type: OnboardingContentViewController.ContentType) {
        currentIndex = type.rawValue
    }
}

//
//  OnboardingPageViewController.swift
//  CarRecognition
//


import UIKit

class OnboardingPageViewController: UIPageViewController {
    
    typealias Page = Int
    
    private var currentIndex = 0
    private var nextIndex = 0
    
    var onChangePage: ((Page) -> Void)?
    
    private lazy var contentViewControllers = [
        OnboardingContentViewController(type: .recognizeCars),
        OnboardingContentViewController(type: .second),
        OnboardingContentViewController(type: .third)
    ]
    
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
    
    func moveToNextPage() {
        guard currentIndex != contentViewControllers.endIndex - 1 else { return }
        currentIndex += 1
        setViewControllers([contentViewControllers[currentIndex]], direction: .forward, animated: true, completion: nil)
    }
    
    private func setupPageViewController() {
        for viewController in contentViewControllers {
            viewController.delegate = self
        }
        setViewControllers([contentViewControllers[0]], direction: .forward, animated: false, completion: nil)
        dataSource = self
        delegate = self
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

extension OnboardingPageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        guard
            let newViewController = pendingViewControllers.first as? OnboardingContentViewController,
            let newIndex = contentViewControllers.index(of: newViewController) else { return }
        nextIndex = newIndex
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if finished {
            currentIndex = nextIndex
            onChangePage?(currentIndex)
        }
    }
}

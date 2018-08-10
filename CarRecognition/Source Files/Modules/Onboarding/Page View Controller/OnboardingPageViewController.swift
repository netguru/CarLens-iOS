//
//  OnboardingPageViewController.swift
//  CarRecognition
//


import UIKit

internal final class OnboardingPageViewController: UIPageViewController {
    
    private var currentIndex = 0
    
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

        setViewControllers([contentViewControllers[0]], direction: .forward, animated: false, completion: nil)
        dataSource = self
    }
    
    func moveToNextPage() {
        guard currentIndex != contentViewControllers.endIndex - 1 else { return }
        currentIndex += 1
        setViewControllers([contentViewControllers[currentIndex]], direction: .forward, animated: true, completion: nil)
    }
}

// MARK: - UIPageViewControllerDataSource
extension OnboardingPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard  let contentViewController = viewController as? OnboardingContentViewController,
            let index = contentViewControllers.index(of: contentViewController) else { return nil }
        let previousIndex = index - 1
        guard contentViewControllers.count > previousIndex, previousIndex >= 0 else { return nil }
        currentIndex = previousIndex
        return contentViewControllers[currentIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let contentViewController = viewController as? OnboardingContentViewController,
            let index = contentViewControllers.index(of: contentViewController) else { return nil }
        let nextIndex = index + 1
        guard contentViewControllers.count != nextIndex, contentViewControllers.count > nextIndex else { return nil }
        currentIndex = nextIndex
        return contentViewControllers[currentIndex]
    }
}

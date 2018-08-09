//
//  OnboardingPageViewController.swift
//  CarRecognition
//


import UIKit

class OnboardingPageViewController: UIPageViewController {
    
    lazy var nextButton: UIButton = {
        let view = UIButton(type: .system)
        view.setImage(#imageLiteral(resourceName: "button-scan-primary"), for: .normal)
        view.addTarget(self, action: #selector(didTouchNextButton), for: .touchUpInside)
        return view.layoutable()
    }()
    
    lazy var indicatorView: UIView = {
        let view = UIView(frame: CGRect.init(origin: .zero, size: CGSize.init(width: 100, height: 40)))
        view.backgroundColor = .green
        return view
    }()
    
    private var currentIndex = 0
    private var nextIndex = 0
    
    private lazy var onboardingViewControllers = [
        OnboardingViewController(type: .recognizeCars),
        OnboardingViewController(type: .second),
        OnboardingViewController(type: .third)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setViewControllers([onboardingViewControllers[0]], direction: .forward, animated: true, completion: nil)
        dataSource = self
        delegate = self
    }
    
    //MARK: - Setup
    
    private func setupUI() {
        [indicatorView, nextButton].forEach { view.addSubview($0) }
        
        setupConstraints()
    }
    
    private func setupConstraints(){
        nextButton.constraintCenterToSuperview(axis: [.horizontal])
        nextButton.constraintToSuperviewLayoutGuide(excludingAnchors: [.top, .left, .right], withInsets: UIEdgeInsets(top: 0, left: 0, bottom: 20.0, right: 0))
    }
    
    //MARK: - Selectors
    @objc
    private func didTouchNextButton() {
        guard currentIndex != onboardingViewControllers.endIndex - 1
            else {
                return
            }
        currentIndex += 1
        setViewControllers([onboardingViewControllers[currentIndex]], direction: .forward, animated: true, completion: nil)
    }
}

// MARK: - UIPageViewControllerDataSource
extension OnboardingPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard
            let onboardingViewController = viewController as? OnboardingViewController,
            let index = onboardingViewControllers.index(of: onboardingViewController)
            else { return nil }
        
        let endIndex = onboardingViewControllers.endIndex - 1
        
        currentIndex = currentIndex == endIndex ? currentIndex : currentIndex + 1
        
        return endIndex == index ? nil : onboardingViewControllers[currentIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard
            let onboardingViewController = viewController as? OnboardingViewController,
            let index = onboardingViewControllers.index(of: onboardingViewController)
            else { return nil }
        
        let startIndex = onboardingViewControllers.startIndex
        
        currentIndex = currentIndex == startIndex ? currentIndex : currentIndex - 1
        
        return onboardingViewControllers.startIndex == index ? nil : onboardingViewControllers[currentIndex]
    }
}

// MARK: - UIPageViewControllerDelegate
extension OnboardingPageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        guard
            let onboardingViewController = pendingViewControllers[0] as? OnboardingViewController,
            let index = onboardingViewControllers.index(of: onboardingViewController) else { return }
        nextIndex = index
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if finished {
            currentIndex = nextIndex
            let endIndex = onboardingViewControllers.endIndex - 1
            UIView.animate(withDuration: 0.5) {
                self.nextButton.alpha = self.currentIndex == endIndex ? 0.0 : 1.0
            }
        }
    }
}

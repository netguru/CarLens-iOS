//
//  OnboardningViewController.swift
//  CarRecognition
//


import UIKit
import Lottie

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
        
        pageViewController.onChangePage = { [weak self] index in
            guard let `self` = self else {
                return
            }
            
            let lottieView = self.customView.indicatorAnimationView
            
            let newProgress: CGFloat
            switch index {
            case 0:
                newProgress = 0
            case 1:
                newProgress = 0.5
            case 3:
                newProgress = 1.0
            default:
                newProgress = 1.0
            }
            if lottieView.isAnimationPlaying {
                lottieView.pause()
            }
            let currentProgress = lottieView.animationProgress
            
            lottieView.play(fromProgress: currentProgress, toProgress: newProgress, withCompletion: nil)
        }
    }
    
    @objc private func didTapNext() {
        pageViewController.moveToNextPage()
    }
}

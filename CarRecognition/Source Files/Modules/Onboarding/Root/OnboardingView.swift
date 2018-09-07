//
//  OnboardingView.swift
//  CarRecognition
//


import UIKit

enum OnboardingTransitionAnimationState {
    
    case onFirst, fromFirstToSecond, fromSecondToThird, fromThirdToSecond, fromSecondToFirst
    
    var animatedImagesRange: CountableClosedRange<Int> {
        switch self {
        case .onFirst:
            return 0...185
        case .fromFirstToSecond,
             .fromSecondToFirst:
            return 186...326
        case .fromSecondToThird,
             .fromThirdToSecond:
            return 327...451
        }
    }
    
    var animatedImages: [UIImage] {
        var images: [UIImage] = []
        switch self {
        case .fromThirdToSecond,
             .fromSecondToFirst:
            for i in animatedImagesRange.reversed() {
                images.append(UIImage(imageLiteralResourceName: "onboarding-animation-\(i)"))
            }
        default:
            for i in animatedImagesRange {
                images.append(UIImage(imageLiteralResourceName: "onboarding-animation-\(i)"))
            }
        }
        return images
    }
    
    init?(fromPage currentPage: Int, to nextPage: Int) {
        let pages = (currentPage, nextPage)
        switch pages {
        case (0, 0):
            self = .onFirst
        case (0, 1):
            self = .fromFirstToSecond
        case (1, 2):
            self = .fromSecondToThird
        case (2, 1):
            self = .fromThirdToSecond
        case (1, 0):
            self = .fromSecondToFirst
        default:
            return nil
        }
    }
}

internal final class OnboardingView: View, ViewSetupable  {
    
    lazy var animatedImageView: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "onboarding-animation-0.png")
        view.contentMode = .scaleAspectFit
        return view.layoutable()
    }()
    
    /// Page View with onboarding screens.
    lazy var pageView = UIView().layoutable()
    
    /// Button indicating a possibility of moving to the next page.
    lazy var nextButton: UIButton = {
        let view = UIButton(type: .system)
        view.accessibilityIdentifier = "onboarding/button/next"
        view.setImage(#imageLiteral(resourceName: "button-next-page"), for: .normal)
        return view.layoutable()
    }()
    
    lazy var pageControl: UIPageControl = {
        let view = UIPageControl().layoutable()
        view.currentPageIndicatorTintColor = UIColor.crOnboardingDeepOrange
        view.pageIndicatorTintColor = UIColor.crOnboardingLightOrange
        view.currentPage = 0
        view.numberOfPages = 3
        return view
    }()
    
    // MARK: - Setup
    func setupViewHierarchy() {
        [animatedImageView, pageView, pageControl, nextButton].forEach { addSubview($0) }
    }
    
    func setupConstraints() {
        animatedImageView.constraintToSuperviewEdges(excludingAnchors: [.bottom])
        pageView.constraintToSuperviewEdges(excludingAnchors: [.top, .bottom])
        
        NSLayoutConstraint.activate([
            animatedImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.55),
            pageView.topAnchor.constraint(equalTo: animatedImageView.bottomAnchor, constant: 4),
            pageView.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: 8),
            pageControl.widthAnchor.constraint(equalToConstant: 150),
            pageControl.heightAnchor.constraint(equalToConstant: 40),
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: 8),
            nextButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: 100),
            nextButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
        ])
    }
    
    func setupProperties() {
        backgroundColor = UIColor.crBackgroundGray
    }
    
    func animateTransition(fromPage currentPage: Int, to nextPage: Int) {
        let animationState = OnboardingTransitionAnimationState(fromPage: currentPage, to: nextPage)
        guard let state = animationState else { return }
        animatedImageView.animationImages = state.animatedImages
        animatedImageView.animationDuration = 3
        animatedImageView.animationRepeatCount = 1
        animatedImageView.startAnimating()
        animatedImageView.image = state.animatedImages.last
    }
}

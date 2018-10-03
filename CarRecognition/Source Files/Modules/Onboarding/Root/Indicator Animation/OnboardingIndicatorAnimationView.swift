//
//  OnboardingIndicatorAnimationView.swift
//  CarRecognition
//


import Foundation
import UIKit

internal class OnboardingIndicatorAnimationView: View, ViewSetupable {
    
    let firstDotView = UIView().layoutable()
    let secondDotView = UIView().layoutable()
    let thirdDotView = UIView().layoutable()
//    let dotsViews: [UIView] = Array.init(repeating: UIView().layoutable(), count: 3)
    let dotWidth: CGFloat = 5
    let dotExtendedWidth: CGFloat = 20
    let spacing: CGFloat = 5
    
    lazy var viewWidth: CGFloat = {
        return dotWidth * 2 + spacing * 2 + dotExtendedWidth
    }()
    
    func animate(fromPage previousPageIndex: Int, to currentPageIndex: Int) {
        guard let state = OnboardingTransitionAnimationState(fromPage: previousPageIndex, to: currentPageIndex) else { return }
        var animations: (() -> Void)?
        switch state {
        case .onFirst:
            return
        case .fromFirstToSecond:
            animations = {
                self.firstDotView.backgroundColor = UIColor.crOnboardingLightOrange
                self.firstDotView.frame = CGRect(x: 0, y: 0, width: self.dotWidth, height: self.dotWidth)
                self.secondDotView.frame = CGRect(x: self.dotWidth + self.spacing, y: 0, width: self.dotExtendedWidth, height: self.dotWidth)
                self.secondDotView.backgroundColor = UIColor.crOnboardingDeepOrange
            }
        case .fromSecondToFirst:
            animations = {
                self.secondDotView.backgroundColor = UIColor.crOnboardingLightOrange
                self.secondDotView.frame = CGRect(x: self.dotExtendedWidth + self.spacing, y: 0, width: self.dotWidth, height: self.dotWidth)
                self.firstDotView.frame = CGRect(x: 0, y: 0, width: self.dotExtendedWidth, height: self.dotWidth)
                self.firstDotView.backgroundColor = UIColor.crOnboardingDeepOrange
            }
        case .fromSecondToThird:
            animations = {
                self.secondDotView.backgroundColor = UIColor.crOnboardingLightOrange
                self.secondDotView.frame = CGRect(x: self.dotWidth + self.spacing, y: 0, width: self.dotWidth, height: self.dotWidth)
                self.thirdDotView.frame = CGRect(x: self.dotWidth * 2 + self.spacing * 2, y: 0, width: self.dotExtendedWidth, height: self.dotWidth)
                self.thirdDotView.backgroundColor = UIColor.crOnboardingDeepOrange
            }
        case .fromThirdToSecond:
            animations = {
                self.thirdDotView.backgroundColor = UIColor.crOnboardingLightOrange
                self.thirdDotView.frame = CGRect(x: self.dotExtendedWidth + self.dotWidth + self.spacing * 2, y: 0, width: self.dotWidth, height: self.dotWidth)
                self.secondDotView.frame = CGRect(x: self.dotWidth + self.spacing, y: 0, width: self.dotExtendedWidth, height: self.dotWidth)
                self.secondDotView.backgroundColor = UIColor.crOnboardingDeepOrange
            }
        }
        guard let animationsArray = animations else { return }
        UIView.animate(withDuration: 0.5, animations: animationsArray)
    }
    
    func setupViewHierarchy() {
        [firstDotView, secondDotView, thirdDotView].forEach { addSubview($0) }
    }
    
    func setupConstraints() {
        firstDotView.frame = CGRect(x: 0, y: 0, width: dotExtendedWidth, height: dotWidth)
        secondDotView.frame = CGRect(x: dotExtendedWidth + spacing, y: 0, width: dotWidth, height: dotWidth)
        thirdDotView.frame = CGRect(x: dotExtendedWidth + spacing * 2 + dotWidth, y: 0, width: dotWidth, height: dotWidth)
    }
    
    func setupProperties() {
        firstDotView.backgroundColor = UIColor.crOnboardingDeepOrange
        firstDotView.layer.cornerRadius = dotWidth/2
        secondDotView.backgroundColor = UIColor.crOnboardingLightOrange
        secondDotView.layer.cornerRadius = dotWidth/2
        thirdDotView.backgroundColor = UIColor.crOnboardingLightOrange
        thirdDotView.layer.cornerRadius = dotWidth/2
    }
}

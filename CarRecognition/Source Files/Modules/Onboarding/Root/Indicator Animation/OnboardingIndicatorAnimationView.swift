//
//  OnboardingIndicatorAnimationView.swift
//  CarRecognition
//


import Foundation
import UIKit

internal class OnboardingIndicatorAnimationView: View, ViewSetupable {
    
    struct Constants {
        static let dotWidth: CGFloat = 5
        static let dotExtendedWidth = dotWidth * 4
        static let spacing: CGFloat = 5
    }
    
    struct Frames {
        struct Extended {
            static let first = CGRect(x: 0, y: 0, width: Constants.dotExtendedWidth, height: Constants.dotWidth)
            static let second = CGRect(x: Constants.dotWidth + Constants.spacing, y: 0, width: Constants.dotExtendedWidth, height: Constants.dotWidth)
            static let third = CGRect(x: Constants.dotWidth * 2 + Constants.spacing * 2, y: 0, width: Constants.dotExtendedWidth, height: Constants.dotWidth)
        }
        
        struct Initial {
            static let first = CGRect(x: 0, y: 0, width: Constants.dotWidth, height: Constants.dotWidth)
            static let secondFromFirst = CGRect(x: Constants.dotExtendedWidth + Constants.spacing, y: 0, width: Constants.dotWidth, height: Constants.dotWidth)
            static let secondFromThird = CGRect(x: Constants.dotWidth + Constants.spacing, y: 0, width: Constants.dotWidth, height: Constants.dotWidth)
            static let third = CGRect(x: Constants.dotExtendedWidth + Constants.dotWidth + Constants.spacing * 2, y: 0, width: Constants.dotWidth, height: Constants.dotWidth)
        }
    }
    
    let firstDotView = UIView().layoutable()
    let secondDotView = UIView().layoutable()
    let thirdDotView = UIView().layoutable()
    let dotViews: [UIView] = Array.init(repeating: UIView().layoutable(), count: 3)
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
                self.firstDotView.frame = Frames.Initial.first
                self.secondDotView.frame = Frames.Extended.second
                self.secondDotView.backgroundColor = UIColor.crOnboardingDeepOrange
            }
        case .fromSecondToThird:
            animations = {
                self.secondDotView.backgroundColor = UIColor.crOnboardingLightOrange
                self.secondDotView.frame = Frames.Initial.secondFromThird
                self.thirdDotView.frame = Frames.Extended.third
                self.thirdDotView.backgroundColor = UIColor.crOnboardingDeepOrange
            }
        case .fromThirdToSecond:
            animations = {
                self.thirdDotView.backgroundColor = UIColor.crOnboardingLightOrange
                self.thirdDotView.frame = Frames.Initial.third
                self.secondDotView.frame = Frames.Extended.second
                self.secondDotView.backgroundColor = UIColor.crOnboardingDeepOrange
            }
        case .fromSecondToFirst:
            animations = {
                self.secondDotView.backgroundColor = UIColor.crOnboardingLightOrange
                self.secondDotView.frame = Frames.Initial.secondFromFirst
                self.firstDotView.frame = Frames.Extended.first
                self.firstDotView.backgroundColor = UIColor.crOnboardingDeepOrange
            }
        }
        guard let animationsArray = animations else { return }
        UIView.animate(withDuration: 0.5, animations: animationsArray)
    }
    
    func setupViewHierarchy() {
        [firstDotView, secondDotView, thirdDotView].forEach { addSubview($0) }
    }
    
    func setupConstraints() {
        firstDotView.frame = Frames.Initial.first
        secondDotView.frame = Frames.Initial.secondFromFirst
        thirdDotView.frame = Frames.Initial.third
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

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
    
    let dotViews: [UIView] = [UIView().layoutable(), UIView().layoutable(), UIView().layoutable()]
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
                self.dotViews[0].backgroundColor = UIColor.crOnboardingLightOrange
                self.dotViews[0].frame = Frames.Initial.first
                self.dotViews[1].frame = Frames.Extended.second
                self.dotViews[1].backgroundColor = UIColor.crOnboardingDeepOrange
            }
        case .fromSecondToThird:
            animations = {
                self.dotViews[1].backgroundColor = UIColor.crOnboardingLightOrange
                self.dotViews[1].frame = Frames.Initial.secondFromThird
                self.dotViews[2].frame = Frames.Extended.third
                self.dotViews[2].backgroundColor = UIColor.crOnboardingDeepOrange
            }
        case .fromThirdToSecond:
            animations = {
                self.dotViews[2].backgroundColor = UIColor.crOnboardingLightOrange
                self.dotViews[2].frame = Frames.Initial.third
                self.dotViews[1].frame = Frames.Extended.second
                self.dotViews[1].backgroundColor = UIColor.crOnboardingDeepOrange
            }
        case .fromSecondToFirst:
            animations = {
                self.dotViews[1].backgroundColor = UIColor.crOnboardingLightOrange
                self.dotViews[1].frame = Frames.Initial.secondFromFirst
                self.dotViews[0].frame = Frames.Extended.first
                self.dotViews[0].backgroundColor = UIColor.crOnboardingDeepOrange
            }
        }
        guard let animationsArray = animations else { return }
        UIView.animate(withDuration: 0.5, animations: animationsArray)
    }
    
    func setupViewHierarchy() {
        dotViews.forEach { addSubview($0) }
    }
    
    func setupConstraints() {
        dotViews[0].frame = Frames.Extended.first
        dotViews[1].frame = Frames.Initial.secondFromFirst
        dotViews[2].frame = Frames.Initial.third
    }
    
    func setupProperties() {
        for (i, view) in dotViews.enumerated() {
            view.layer.cornerRadius = Constants.dotWidth/2
            view.backgroundColor = (i == 0) ? UIColor.crOnboardingDeepOrange : UIColor.crOnboardingLightOrange
        }
    }
}

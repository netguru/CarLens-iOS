//
//  OnboardingIndicatorAnimationView.swift
//  CarRecognition
//


import Foundation
import UIKit

internal class OnboardingIndicatorAnimationView: View, ViewSetupable {
    
    private struct Constants {
        static let dotWidth: CGFloat = 5
        static let dotExtendedWidth = dotWidth * 4
        static let spacing: CGFloat = 5
    }
    
    private let dotViews = [UIView().layoutable(), UIView().layoutable(), UIView().layoutable()]
    
    private(set) var viewWidth = Constants.dotWidth * 2 + Constants.spacing * 2 + Constants.dotExtendedWidth
    private(set) var viewHeight = Constants.dotWidth
    
    func animate(fromPage previousPageIndex: Int, to currentPageIndex: Int) {
        guard previousPageIndex != currentPageIndex else { return }
        UIView.animate(withDuration: 0.5) {
            self.dotViews[previousPageIndex].backgroundColor = UIColor.crOnboardingLightOrange
            self.dotViews[currentPageIndex].backgroundColor = UIColor.crOnboardingDeepOrange
            self.dotViews[previousPageIndex].frame = self.initialFrame(forDot: previousPageIndex, extendedDot: currentPageIndex)
            self.dotViews[currentPageIndex].frame = self.extendedFrame(forDot: currentPageIndex)
        }
    }
    
    func setupViewHierarchy() {
        dotViews.forEach { addSubview($0) }
    }
    
    func setupConstraints() {
        dotViews[0].frame = extendedFrame(forDot: 0)
        dotViews[1].frame = initialFrame(forDot: 1, extendedDot: 0)
        dotViews[2].frame = initialFrame(forDot: 2)
    }
    
    func setupProperties() {
        for (i, view) in dotViews.enumerated() {
            view.layer.cornerRadius = Constants.dotWidth/2
            view.backgroundColor = (i == 0) ? UIColor.crOnboardingDeepOrange : UIColor.crOnboardingLightOrange
        }
    }
    
    private func extendedFrame(forDot dot: Int) -> CGRect {
        let dotWidthWithSpacing = Constants.dotWidth + Constants.spacing
        let x: CGFloat
        switch dot {
        case 0:
            x = 0
        case 1:
            x = dotWidthWithSpacing
        case 2:
            x = dotWidthWithSpacing * 2
        default:
            x = 0
        }
        return frame(forX: x, width: Constants.dotExtendedWidth)
    }
    
    private func initialFrame(forDot dot: Int, extendedDot: Int? = nil) -> CGRect {
        let dotWidthWithSpacing = Constants.dotWidth + Constants.spacing
        let extendedDotWidthWithSpacing = Constants.dotExtendedWidth + Constants.spacing
        let x: CGFloat
        switch dot {
        case 0:
            x = 0
        case 1:
            guard let extendedDot = extendedDot else { return CGRect(x: 0, y: 0, width: 0, height: 0) }
            x = (extendedDot == 0) ? extendedDotWidthWithSpacing : dotWidthWithSpacing
        case 2:
            x = extendedDotWidthWithSpacing + dotWidthWithSpacing
        default:
            x = 0
        }
        return frame(forX: x, width: Constants.dotWidth)
    }
    
    private func frame(forX x: CGFloat, width: CGFloat) -> CGRect {
        return CGRect(x: x, y: 0, width: width, height: Constants.dotWidth)
    }
}

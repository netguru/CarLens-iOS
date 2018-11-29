//
//  OnboardingTransitionAnimationState.swift
//  CarRecognition
//


import Foundation
import AVKit

/// Enum indicating the state of the transition between pages.
enum OnboardingTransitionAnimationState {
    
    case onFirst, fromFirstToSecond, fromSecondToThird, fromThirdToSecond, fromSecondToFirst
    
    var startingTime: CMTime {
        let value: Int64
        switch self {
        case .onFirst,
             .fromSecondToFirst:
            value = 0
        case .fromFirstToSecond,
             .fromThirdToSecond:
            value = Constants.OnboardingAnimation.StartFrames.secondScreen
        case .fromSecondToThird:
            value = Constants.OnboardingAnimation.StartFrames.thirdScreen
        }
        return CMTimeMake(value: value, timescale: 60)
    }
    
    var endingTime: CMTime {
        let value: Int64
        switch self {
        case .onFirst,
             .fromSecondToFirst:
            value = Constants.OnboardingAnimation.FinishFrames.firstScreen
        case .fromFirstToSecond,
             .fromThirdToSecond:
            value = Constants.OnboardingAnimation.FinishFrames.secondScreen
        case .fromSecondToThird:
            value = Constants.OnboardingAnimation.FinishFrames.thirdScreen
        }
        return CMTimeMake(value: value, timescale: 60)
    }
    
    /// Initializing the OnboardingTransitionAnimationState instance.
    ///
    /// - Parameters:
    /// - previousPageIndex: Previous page from which user transitioned.
    /// - currentPageIndex: Page on which user is currently now.
    init?(fromPage previousPageIndex: Int, to currentPageIndex: Int) {
        let pages = (previousPageIndex, currentPageIndex)
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

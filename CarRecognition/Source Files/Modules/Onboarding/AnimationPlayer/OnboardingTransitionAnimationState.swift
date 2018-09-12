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
            value = 184
        case .fromSecondToThird:
            value = 334
        }
        return CMTimeMake(value, 60)
    }
    
    var endingTime: CMTime? {
        let value: Int64
        switch self {
        case .onFirst,
             .fromSecondToFirst:
            value = 184
        case .fromFirstToSecond,
             .fromThirdToSecond:
            value = 334
        case .fromSecondToThird:
            return nil
        }
        return CMTimeMake(value, 60)
    }
    
    /// Initializing the OnboardingTransitionAnimationState instance
    ///
    /// - Parameters:
    /// - currentPageIndex: Page on which user is currently now.
    /// - nextPageIndex: Next page to which user wants to transition.
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

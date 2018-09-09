//
//  OnboardingTransitionAnimationState.swift
//  CarRecognition
//


import Foundation

/// Enum indicating the state of the transition between pages.
enum OnboardingTransitionAnimationState {
    
    case onFirst, fromFirstToSecond, fromSecondToThird, fromThirdToSecond, fromSecondToFirst
    
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

//
//  OnboardingTransitionAnimationState.swift
//  CarRecognition
//


import Foundation
import AVKit

/// Enum indicating the state of the transition between pages.
enum OnboardingTransitionAnimationState {
    
    case first, second, third
    
    var startingTime: CMTime {
        let value: Int64
        switch self {
        case .first:
            value = 0
        case .second:
            value = 184
        case .third:
            value = 334
        }
        return CMTimeMake(value, 60)
    }
    
    var endingTime: CMTime? {
        let value: Int64
        switch self {
        case .first:
            value = 184
        case .second:
            value = 334
        case .third:
            return nil
        }
        return CMTimeMake(value, 60)
    }
    
    /// Initializing the OnboardingTransitionAnimationState instance
    ///
    /// - Parameters:
    /// - currentPageIndex: Page on which user is currently now.
    /// - nextPageIndex: Next page to which user wants to transition.
    init?(toPage nextPage: Int) {
        switch nextPage {
        case 0:
            self = .first
        case 1:
            self = .second
        case 2:
            self = .third
        default:
            return nil
        }
    }
}

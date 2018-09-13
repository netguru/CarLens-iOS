//
//  ApplicationConstants.swift
//  CarRecognition
//

/// Keeping the constant values used in the project.
struct Constants {
    
    /// Constants used for onboarding animation.
    struct OnboardingAnimation {
        
        /// Video frames from which the animation should start.
        struct StartFrames {
            static let secondScreen: Int64 = 184
            static let thirdScreen: Int64 = 334
        }
        
        /// Video frames at which the animation should end.
        struct FinishFrames {
            static let firstScreen = StartFrames.secondScreen
            static let secondScreen = StartFrames.thirdScreen
            static let thirdScreen: Int64 = 452
        }
        
        static let initialAnimationDelayInMilliseconds = 400
    }
    
}

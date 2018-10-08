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
    
    /// Constants used in recognition process.
    struct Recognition {
        
        ///Thresholds for the recognition confidence values.
        struct Threshold {
            
            /// Minimum threshold filtering the results at the beginning.
            static let minimum: Float = 0.1
            
            /// Threshold stating whether the recognition of the car is in progress.
            static let neededToShowProgress: Float = 0.4
        
            /// Confidence needed to pin the AR label.
            static let neededToPinARLabel: Float = 0.75
        }
        
        /// Number of last results that should be normalized.
        static let normalizationCount = 5
    }
}

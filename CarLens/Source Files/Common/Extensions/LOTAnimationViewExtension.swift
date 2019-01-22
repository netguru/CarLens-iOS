//
//  LOTAnimationViewExtension.swift
//  CarLens
//


import Lottie

extension LOTAnimationView {

    /// Sets the progress on the animation
    ///
    /// - Parameters:
    ///   - progress: Progress to be set
    ///   - animated: Indicating if change should be animated
    func set(progress: CGFloat, animated: Bool) {
        if animated {
            play(toProgress: progress)
        } else {
            animationProgress = progress
        }
    }
}

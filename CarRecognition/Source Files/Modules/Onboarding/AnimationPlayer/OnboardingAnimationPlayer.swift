//
//  OnboardingAnimationPlayer.swift
//  CarRecognition
//


import Foundation
import AVKit

/// Class which handles onboarding animation by using AVPlayerViewController.
internal final class OnboardingAnimationPlayer {
    
    private var bundle: Bundle
    
    private var animationState: OnboardingTransitionAnimationState = .onFirst
    
    private var animatedVideoPath: String? {
        // TODO: add proper paths as designs arrive.
        switch animationState {
        case .onFirst:
            return bundle.path(forResource: "Onboarding", ofType: "mp4")
        case .fromFirstToSecond:
            return bundle.path(forResource: "Onboarding", ofType: "mp4")
        case .fromSecondToThird:
            return bundle.path(forResource: "Onboarding", ofType: "mp4")
        case .fromSecondToFirst:
            return bundle.path(forResource: "Onboarding", ofType: "mp4")
        case .fromThirdToSecond:
            return bundle.path(forResource: "Onboarding", ofType: "mp4")
        }
    }
    
    init(with bundle: Bundle = Bundle.main) {
        self.bundle = bundle
    }
    
    /// Video View Controller, which playes video as an animation.
    lazy var playerViewController: AVPlayerViewController = {
        let viewController = AVPlayerViewController()
        guard let videoPath = animatedVideoPath else { return viewController }
        let videoUrl = URL(fileURLWithPath: videoPath)
        viewController.player = AVPlayer(url: videoUrl)
        viewController.showsPlaybackControls = false
        return viewController
    }()
    
    /// Handling animation of the view by changing the content video.
    ///
    /// - Parameters:
    /// - currentPageIndex: Page on which user is currently now.
    /// - nextPageIndex: Next page to which user wants to transition.
    func animate(fromPage currentPageIndex: Int, to nextPageIndex: Int) {
        guard let state = OnboardingTransitionAnimationState(fromPage: currentPageIndex, to: nextPageIndex) else { return }
        animationState = state
        playerViewController.player?.pause()
        updatePlayer()
        playerViewController.player?.play()
    }
    
    private func updatePlayer() {
        guard let videoPath = animatedVideoPath else { return }
        let videoUrl = URL(fileURLWithPath: videoPath)
        playerViewController.player = AVPlayer(url: videoUrl)
    }
 
}

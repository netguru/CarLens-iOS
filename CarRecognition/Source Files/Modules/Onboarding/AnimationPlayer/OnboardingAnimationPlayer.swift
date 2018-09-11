//
//  OnboardingAnimationPlayer.swift
//  CarRecognition
//


import Foundation
import AVKit

/// Class which handles onboarding animation by using AVPlayerViewController.
internal final class OnboardingAnimationPlayer {
    
    private var bundle: Bundle
    
    private var animationState: OnboardingTransitionAnimationState = .first
    
    private var playerObserver: Any?
    
    private var isPlaying = false
    
    init(with bundle: Bundle = Bundle.main) {
        self.bundle = bundle
    }
    
    /// Video View Controller, which playes video as an animation.
    lazy var playerViewController: AVPlayerViewController = {
        let viewController = AVPlayerViewController()
        guard let videoPath = bundle.path(forResource: "onboarding", ofType: "mp4") else { return viewController }
        let videoUrl = URL(fileURLWithPath: videoPath)
        viewController.player = AVPlayer(url: videoUrl)
        viewController.showsPlaybackControls = false
        viewController.player?.externalPlaybackVideoGravity = .resizeAspectFill
        return viewController
    }()
    
    /// Handling animation of the view by changing the content video.
    ///
    /// - Parameters:
    /// - currentPageIndex: Page on which user is currently now.
    /// - nextPageIndex: Next page to which user wants to transition.
    func animate(fromPage currentPageIndex: Int, to nextPageIndex: Int) {
        guard let state = OnboardingTransitionAnimationState(toPage: nextPageIndex) else { return }
        animationState = state
//        guard !isPlaying else {
//            removeTimeObserver()
//            return
//        }
//        playerViewController.player?.pause()

        switch animationState {
        case .first:
            let deadlineTime = DispatchTime.now() + .milliseconds(600)
            DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: {
                self.addTimeObserver(for: state.endingTime)
                self.playerViewController.player?.play()
//                self.isPlaying = true
            })
        case .second:
            removeTimeObserver()
            addTimeObserver(for: state.endingTime)
            self.playerViewController.player?.seek(to: state.startingTime)
            playerViewController.player?.play()
        case .third:
            removeTimeObserver()
            self.playerObserver = nil
            self.playerViewController.player?.seek(to: state.startingTime)
            playerViewController.player?.play()
        }
        
    }
 
    private func removeTimeObserver() {
        guard let playerObserver = playerObserver else {
            return
        }
        playerViewController.player?.removeTimeObserver(playerObserver)
    }
    
    private func addTimeObserver(for time: CMTime?) {
        removeTimeObserver()
        guard let time = time else {
            playerObserver = nil
            return
        }
        self.playerObserver = playerViewController.player?.addBoundaryTimeObserver(forTimes: [NSValue.init(time: time)], queue: nil, using: { [weak self] in
            self?.playerViewController.player?.pause()
//            self?.isPlaying = false
        })
    }
}

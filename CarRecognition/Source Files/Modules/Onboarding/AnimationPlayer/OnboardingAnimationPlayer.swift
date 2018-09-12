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
    
    private var playerObserver: Any?
    
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
        viewController.view.backgroundColor = UIColor.clear
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
        switch animationState {
        case .onFirst:
            let deadlineTime = DispatchTime.now() + .milliseconds(400)
            DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: {
                self.addTimeObserver(for: state.endingTime)
                self.playerViewController.player?.play()
            })
            return
        case .fromFirstToSecond,
             .fromSecondToThird,
             .fromSecondToFirst:
            removeTimeObserver()
        case .fromThirdToSecond:
            break
        }
        addTimeObserver(for: state.endingTime)
        playerViewController.player?.seek(to: state.startingTime)
        playerViewController.player?.play()
    }
 
    private func removeTimeObserver() {
        guard let playerObserver = playerObserver else {
            return
        }
        playerViewController.player?.removeTimeObserver(playerObserver)
    }
    
    private func addTimeObserver(for time: CMTime?) {
        guard let time = time else {
            playerObserver = nil
            return
        }
        self.playerObserver = playerViewController.player?.addBoundaryTimeObserver(forTimes: [NSValue.init(time: time)], queue: nil, using: { [weak self] in
            self?.playerViewController.player?.pause()
        })
    }
}

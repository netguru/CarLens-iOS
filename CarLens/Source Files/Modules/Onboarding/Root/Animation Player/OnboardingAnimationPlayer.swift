//
//  OnboardingAnimationPlayer.swift
//  CarLens
//


import Foundation
import AVKit

/// Class which handles onboarding animation by using AVPlayerViewController.
final class OnboardingAnimationPlayer {

    private var bundle: Bundle

    private var animationState: OnboardingTransitionAnimationState = .onFirst

    private var playerTimeObserver: Any?

    init(with bundle: Bundle = Bundle.main) {
        self.bundle = bundle
    }

    /// Video View Controller which playes video as an animation.
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
    ///    - previousPageIndex: Previous page from which user transitioned.
    ///    - currentPageIndex: Page on which user is currently now.
    func animate(fromPage previousPageIndex: Int, to currentPageIndex: Int) {
        guard let state = OnboardingTransitionAnimationState(fromPage: previousPageIndex, to: currentPageIndex)
            else { return }
        animationState = state
        switch animationState {
        case .onFirst:
            let deadlineTime = DispatchTime.now() +
                .milliseconds(Constants.OnboardingAnimation.initialAnimationDelayInMilliseconds)
            DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: {
                self.addTimeObserver(for: state.endingTime)
                self.playerViewController.player?.play()
            })
            return
        case .fromFirstToSecond, .fromSecondToFirst:
            removeTimeObserver()
            addTimeObserver(for: state.endingTime)
        case .fromSecondToThird:
            removeTimeObserver()
        case .fromThirdToSecond:
            addTimeObserver(for: state.endingTime)
        }
        playerViewController.player?.seek(to: state.startingTime)
        playerViewController.player?.play()
    }

    private func removeTimeObserver() {
        guard let playerTimeObserver = playerTimeObserver else { return }
        playerViewController.player?.removeTimeObserver(playerTimeObserver)
        self.playerTimeObserver = nil
    }

    private func addTimeObserver(for time: CMTime) {
        self.playerTimeObserver = playerViewController.player?
            .addBoundaryTimeObserver(forTimes: [NSValue.init(time: time)], queue: nil, using: { [weak self] in
            self?.playerViewController.player?.pause()
        })
    }
}

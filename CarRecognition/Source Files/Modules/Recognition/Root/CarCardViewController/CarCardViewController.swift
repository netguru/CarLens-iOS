//
//  CarCardViewController.swift
//  CarRecognition
//


import UIKit

internal final class CarCardViewController: TypedViewController<CarCardView> {

    struct Constants {
        static let entryPosition = UIScreen.main.bounds.maxY / 2
        static let exitPosition = UIScreen.main.bounds.maxY
    }

    /// Completion handler for card status
    var completionHandler: ((Bool) -> ())?
    
    /// Animator for entry animations
    private let entryAnimator = UIViewPropertyAnimator(duration: 1.0, curve: .easeIn)

    /// Animator for exit animations
    private let exitAnimator = UIViewPropertyAnimator(duration: 0.7, curve: .linear)
    
    /// SeeAlso: UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProperties()
    }

    /// Sets up properties of view controller
    private func setupProperties() {
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        view.addGestureRecognizer(gestureRecognizer)
        view.backgroundColor = .clear
    }

    /// Target for UIPanGestureRecogniser recognizer
    @objc func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            exitAnimator.addAnimations {
                let frame = self.view.frame
                self.view.frame = CGRect(x: 0, y: Constants.exitPosition, width: frame.width, height: frame.height)
            }
            exitAnimator.pausesOnCompletion = true
            exitAnimator.pauseAnimation()
        case .changed:
            let translation = recognizer.translation(in: view)
            exitAnimator.fractionComplete = translation.y / Constants.entryPosition
            
            if recognizer.direction == .bottomToTop, exitAnimator.fractionComplete == 0 {
                exitAnimator.stopAnimation(true)
                UIView.animate(withDuration: 0.5) {
                    self.view.frame = CGRect(x: 0, y: Constants.entryPosition, width: self.view.frame.width, height: self.view.frame.height)
                }
            }
        case .ended:
            exitAnimator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
            completionHandler?(true)
        default: break
        }
    }
    
    /// Animates card view from bottom of screen to desired position
    func animateIn() {
        entryAnimator.addAnimations {
            let frame = self.view.frame
            self.view.frame = CGRect(x: 0, y: Constants.entryPosition, width: frame.width, height: frame.height)
        }
        entryAnimator.startAnimation()
    }
}

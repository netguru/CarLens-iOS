//
//  CarCardViewController.swift
//  CarRecognition
//


import UIKit

internal final class CarCardViewController: TypedViewController<CarCardView> {

    /// Animator for entry animations
    private let exitAnimator = UIViewPropertyAnimator(duration: 1.0, curve: .linear)
    
    /// Animator for exit animations
    private let entryAnimator = UIViewPropertyAnimator(duration: 1.0, curve: .linear)
    
    /// Car instance
    private let car: Car

    init(viewMaker: @autoclosure @escaping () -> CarCardView, car: Car) {
        self.car = car
        super.init(viewMaker: viewMaker)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupProperties()
    }

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
                self.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.maxY + frame.height, width: frame.width, height: frame.height)
            }
            exitAnimator.pausesOnCompletion = true
            exitAnimator.pauseAnimation()
        case .changed:
            let translation = recognizer.translation(in: view)
            exitAnimator.fractionComplete = translation.y / view.frame.height
        case .ended:
            exitAnimator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        default: break
        }
    }
    
    /// Animates card view from bottom of screen to desired position
    func animateIn() {
        entryAnimator.addAnimations {
            let frame = self.view.frame
            let yComponent = UIScreen.main.bounds.height / 2
            self.view.frame = CGRect(x: 0, y: yComponent, width: frame.width, height: frame.height)
        }
        entryAnimator.startAnimation()
    }
}

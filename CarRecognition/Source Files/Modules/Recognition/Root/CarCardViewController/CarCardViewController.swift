//
//  CarCardViewController.swift
//  CarRecognition
//


import UIKit

internal final class CarCardViewController: TypedViewController<CarCardView> {

    let animator = UIViewPropertyAnimator(duration: 1.0, curve: .linear)

    /// SeeAlso: UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()

        setupProperties()
    }

    private func setupProperties() {
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(handlePan))
        view.addGestureRecognizer(gesture)
        view.backgroundColor = .clear
    }

    /// Target for panGesture recognizer
    @objc func handlePan(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            animator.addAnimations {
                self.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.maxY + self.view.frame.height, width: self.view.frame.width, height: self.view.frame.height)
            }
            animator.pausesOnCompletion = true
            animator.pauseAnimation()
        case .changed:
            let translation = recognizer.translation(in: view)
            animator.fractionComplete = translation.y / view.frame.height
        case .ended:
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        default: break
        }
    }
}

extension CarCardViewController {
    func animateIn() {
        let animator = UIViewPropertyAnimator(duration: 1.0, curve: .linear) {
            let frame = self.view.frame
            let yComponent: CGFloat = UIScreen.main.bounds.height / 2
            self.view.frame = CGRect(x: 0, y: yComponent, width: frame.width, height: frame.height)
        }
        animator.startAnimation()
    }
}

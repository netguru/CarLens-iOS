//
//  CarCardViewController.swift
//  CarLens
//


import UIKit

final class CarCardViewController: TypedViewController<CarCardView> {

    /// Enum describing events that can be triggered by this controller
    ///
    /// - didTapCarsList: Called when user tapped the car list button passing the displayed car object
    /// - didTapSearchGoogle: Called when user tapped the google search button passing the displayed car object
    /// - didDismissViewByScanButtonTap: Called when user dissmissed the view by tapping the primary scan button
    /// - didDismissView: Called when user dismissed the view using pan gesture
    enum Event {
        case didTapCarsList(Car)
        case didTapSearchGoogle(Car)
        case didDismissViewByScanButtonTap
        case didDismissView
    }

    enum Constants {
        static let cardHeight: CGFloat = 420
        static let entryPosition = UIScreen.main.bounds.maxY - Constants.cardHeight
        static let exitPosition = UIScreen.main.bounds.maxY
    }

    /// Callback with triggered event
    var eventTriggered: ((Event) -> Void)?

    private let entryAnimator = UIViewPropertyAnimator(duration: 0.6, curve: .easeOut)

    private let exitAnimator = UIViewPropertyAnimator(duration: 0.4, curve: .easeOut)

    private let car: Car

    /// Initializes the view controller with given parameters
    ///
    /// - Parameter car: Car to be displayed by the view controller
    init(car: Car) {
        self.car = car
        super.init(viewMaker: CarCardView(car: car))
    }

    /// SeeAlso: UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProperties()
    }

    /// Animates card view from bottom of screen to desired position
    func animateIn() {
        entryAnimator.addCompletion { [unowned self] _ in
			self.customView.setCharts(animated: true, toZero: false)
        }
        entryAnimator.addAnimations {
            let frame = self.view.frame
            self.view.frame = CGRect(x: 0, y: Constants.entryPosition, width: frame.width, height: frame.height)
        }
        entryAnimator.startAnimation()
    }

    /// Animates card view from center of the screen to the bottom
    func animateOut() {
        exitAnimator.addAnimations {
            let frame = self.view.frame
            self.view.frame = CGRect(x: 0, y: Constants.exitPosition, width: frame.width, height: frame.height)
        }
        exitAnimator.startAnimation()
        eventTriggered?(.didDismissView)
    }

    /// Sets up properties of view controller
    private func setupProperties() {
        customView.googleButton.addTarget(self, action: #selector(googleButtonTapAction), for: .touchUpInside)
        customView.carListButton.addTarget(self, action: #selector(carsListButtonTapAction), for: .touchUpInside)
        customView.scanButton.addTarget(self, action: #selector(primaryButtonTapAction), for: .touchUpInside)
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        view.addGestureRecognizer(gestureRecognizer)
        view.backgroundColor = .clear
    }

    /// Target for UIPanGestureRecogniser recognizer
    @objc private func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
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
                    self.view.frame = CGRect(x: 0,
                                             y: Constants.entryPosition,
                                             width: self.view.frame.width,
                                             height: self.view.frame.height)
                }
            }
        case .ended:
            exitAnimator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
            eventTriggered?(.didDismissView)
        default: break
        }
    }

    @objc private func carsListButtonTapAction() {
        customView.hideRippleEffect()
        eventTriggered?(.didTapCarsList(car))
    }

    @objc private func googleButtonTapAction() {
        eventTriggered?(.didTapSearchGoogle(car))
    }

    @objc private func primaryButtonTapAction() {
        animateOut()
        eventTriggered?(.didDismissViewByScanButtonTap)
    }
}

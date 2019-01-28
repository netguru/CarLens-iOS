//
//  CameraAccessViewController.swift
//  CarLens
//


import UIKit

final class CameraAccessViewController: TypedViewController<CameraAccessView> {

    /// Enum describing events that can be triggered by this controller
    ///
    /// - didTriggerShowCarsList: Send when user should see the list of available cars passing car
    ///                           if any is displayed be the bottom sheet.
    /// - didTriggerRequestAccess: Send when user should open Settings with camera access.
    enum Event {
        case didTriggerShowCarsList
        case didTriggerRequestAccess
    }

    /// - SeeAlso: 'UIViewController'
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    /// Callback with triggered event
    var eventTriggered: ((Event) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCallbacks()
    }

    private func setupCallbacks() {
        customView.carsListButton.addTarget(self, action: #selector(carsListButtonTapAction), for: .touchUpInside)
        customView.accessButton.addTarget(self, action: #selector(accessButtonTapAction), for: .touchUpInside)
    }

    @objc private func carsListButtonTapAction() {
        eventTriggered?(.didTriggerShowCarsList)
    }

    @objc private func accessButtonTapAction() {
        eventTriggered?(.didTriggerRequestAccess)
    }
}

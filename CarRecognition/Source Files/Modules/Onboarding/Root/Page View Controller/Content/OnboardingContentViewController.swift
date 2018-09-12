//
//  OnboardingViewController.swift
//  CarRecognition
//


import UIKit

// Intefrace for notifying parent view controller about current page
protocol OnboardingContentPresentable: class {
    
    /// Notifying that soon the new page will be presented.
    ///
    /// - Parameter onboardingContentViewController: View Controller to be presented.
    func willPresentOnboardingContentViewController(_ onboardingContentViewController: OnboardingContentViewController)
    
    /// Notifying that the new page was presented.
    ///
    /// - Parameter onboardingContentViewController: View Controller that was presented.
    func didPresentOnboardingContentViewController(_ onboardingContentViewController: OnboardingContentViewController)
}

internal final class OnboardingContentViewController: TypedViewController<OnboardingContentView> {
    
    /// Delegate used to inform about current page
    weak var delegate: OnboardingContentPresentable?
    
    /// The index of the current view controller.
    var type: ContentType
    
    enum ContentType: Int {
        case first
        case second
        case third
    
        var title: String {
            switch self {
            case .first:
                return Localizable.Onboarding.Title.first
            case .second:
                return Localizable.Onboarding.Title.second
            case .third:
                return Localizable.Onboarding.Title.third
            }
        }
        
        var info: String {
            switch self {
            case .first:
                return Localizable.Onboarding.Description.first
            case .second:
                return Localizable.Onboarding.Description.second
            case .third:
                return Localizable.Onboarding.Description.third
            }
        }
    }

    init(type: ContentType) {
        self.type = type
        super.init(viewMaker: OnboardingContentView())
        customView.setup(with: type.title, infoText: type.info)
    }

    /// SeeAlso: UIViewController
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        delegate?.willPresentOnboardingContentViewController(self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        delegate?.didPresentOnboardingContentViewController(self)
    }
}

//
//  OnboardingViewController.swift
//  CarRecognition
//


import UIKit

// Intefrace for notifying parent view controller about current page
protocol OnboardingContentPresentable: class {
    /// Notify about current page
    ///
    ///   Parameter type: Type of current page
    func didPresentControllerWithType(_ type: OnboardingContentViewController.ContentType)
}

internal final class OnboardingContentViewController: TypedViewController<OnboardingContentView> {
    
    /// Delegate used to inform about current page
    weak var delegate: OnboardingContentPresentable?
    
    private var type: ContentType
    
    enum ContentType: Int {
        case first
        case second
        case third
        
        var image: UIImage {
            return UIImage(imageLiteralResourceName: "onboarding-image-\(rawValue + 1)")
        }
        
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
        customView.setup(with: type.image, titleText: type.title, infoText: type.info)
    }

    /// SeeAlso: UIViewController
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        delegate?.didPresentControllerWithType(type)
    }
}

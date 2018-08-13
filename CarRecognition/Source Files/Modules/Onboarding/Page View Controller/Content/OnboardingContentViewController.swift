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
                return "Recognize Cars"
            case .second:
                return "Discover Cars"
            case .third:
                return "Stay updated"
            }
        }
        
        var info: String {
            switch self {
            case .first:
                return "Point the camera at the front of the car for the best results in image recognition."
            case .second:
                return "Search and unlock the models avaliable in the gallery. Catch them all."
            case .third:
                return "Fllow the updates. The app is still in development, and we working on adding more cars."
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

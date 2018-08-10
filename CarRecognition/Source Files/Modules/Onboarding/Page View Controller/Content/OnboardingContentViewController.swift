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

class OnboardingContentViewController: TypedViewController<OnboardingContentView> {
    
    /// Delegate used to inform about current page
    weak var delegate: OnboardingContentPresentable?
    
    private var type: ContentType
    
    enum ContentType: Int {
        case recognizeCars
        case second //TODO: change once it's ready
        case third //TODO: change once it's ready
        
        var image: UIImage {
            switch self {
            case .recognizeCars:
                return UIImage() //TODO: add once it's ready
            case .second:
                return UIImage() //TODO: add once it's ready
            case .third:
                return UIImage() //TODO: add once it's ready
            }
        }
        
        var title: String {
            switch self {
            case .recognizeCars:
                return "Recognize Cars"
            case .second:
                return "Second" //TODO: change once it's ready
            case .third:
                return "Third"  //TODO: change once it's ready
            }
        }
        
        var info: String {
            switch self {
            case .recognizeCars:
                return "Point the camera at the front of the car for the best results in image recognition"
            case .second:
                return "Point the camera at the front of the car for the best results in image recognition" //TODO: change once it's ready
            case .third:
                return "Point the camera at the front of the car for the best results in image recognition" //TODO: change once it's ready
            }
        }
    }

    init(type: ContentType) {
        self.type = type
        super.init(viewMaker: OnboardingContentView())
        customView.mainImageView.image = type.image
        customView.titleLabel.text = type.title
        customView.infoLabel.text = type.info
    }

    /// SeeAlso: UIViewController
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        delegate?.didPresentControllerWithType(type)
    }
}

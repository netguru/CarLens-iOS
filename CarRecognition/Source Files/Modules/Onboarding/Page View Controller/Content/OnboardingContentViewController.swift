//
//  OnboardingViewController.swift
//  CarRecognition
//


import UIKit

class OnboardingContentViewController: TypedViewController<OnboardingContentView> {
    
    enum `Type` {
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

    init(type: Type) {
        super.init(viewMaker: OnboardingContentView())
        
        customView.mainImageView.image = type.image
        customView.titleLabel.text = type.title
        customView.infoLabel.text = type.info
    }
    
    
}

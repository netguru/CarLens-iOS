//
//  CarClassifierResponse.swift
//  CarRecognition
//

import UIKit.UIImage

internal struct CarClassifierResponse {
    
    let cars: [RecognitionResult]
    let analyzeDuration: TimeInterval
    let analyzedImage: UIImage
}

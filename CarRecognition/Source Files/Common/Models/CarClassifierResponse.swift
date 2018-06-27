//
//  CarClassifierResponse.swift
//  CarRecognition
//

import UIKit.UIImage

internal struct CarClassifierResponse {
    let cars: [RecognizedCar]
    let analyzeDuration: TimeInterval
    let analyzedImage: UIImage
}

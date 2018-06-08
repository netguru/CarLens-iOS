//
//  CarRecognizeResponse.swift
//  CarRecognition
//

import UIKit.UIImage

internal struct CarRecognizeResponse {
    let cars: [RecognizedCar]
    let analyzeDuration: TimeInterval
}

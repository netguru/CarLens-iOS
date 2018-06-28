//
//  RecognizedCar.swift
//  CarRecognition
//


internal struct RecognizedCar: Equatable {
    let car: String
    let confidence: Float
    
    /// Description with confidence formatted in percents
    var descriptionWithConfidence: String {
        return "\(car)\n(\(CRNumberFormatter.percentageFormatted(confidence)))"
    }
    
    /// Splitted model name from the car phrase
    var splittedModelName: String {
        return String(car.split(separator: " ").last ?? "")
    }
    
    public static func == (lhs: RecognizedCar, rhs: RecognizedCar) -> Bool {
        return lhs.car == rhs.car
    }
}

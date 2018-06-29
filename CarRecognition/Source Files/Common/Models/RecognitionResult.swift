//
//  RecognitionResult.swift
//  CarRecognition
//


/// Describes car recognized by the classifier
internal struct RecognitionResult: Equatable, CustomStringConvertible {
    
    let car: Car
    let confidence: Float
    
    init?(label: String, confidence: Float) {
        guard let car = Car(label: label) else { return nil }
        self.car = car
        self.confidence = confidence
    }
    
    /// SeeAlso: CustomStringConvertible
    var description: String {
        return "\(car.description)\n(\(CRNumberFormatter.percentageFormatted(confidence)))"
    }
    
    public static func == (lhs: RecognitionResult, rhs: RecognitionResult) -> Bool {
        return lhs.car == rhs.car
    }
}

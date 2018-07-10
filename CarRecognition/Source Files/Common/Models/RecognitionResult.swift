//
//  RecognitionResult.swift
//  CarRecognition
//


/// Describes car recognized by the classifier
internal struct RecognitionResult: Equatable, CustomStringConvertible {
    
    let car: Car
    let confidence: Float
    
    init?(label: String, confidence: Float, carsDataService: CarsDataService) {
        guard let car = carsDataService.map(classifierLabel: label) else { return nil }
        self.car = car
        self.confidence = confidence
    }
    
    /// SeeAlso: CustomStringConvertible
    var description: String {
        return "\(car.description)\n(\(CRNumberFormatter.percentageFormatted(confidence)))"
    }
    
    /// SeeAlso: Equatable
    static func == (lhs: RecognitionResult, rhs: RecognitionResult) -> Bool {
        return lhs.car == rhs.car
    }
}

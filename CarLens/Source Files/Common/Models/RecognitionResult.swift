//
//  RecognitionResult.swift
//  CarLens
//


/// Describes car recognized by the classifier
internal struct RecognitionResult: CustomStringConvertible {

    /// Available recognitions
    enum Recognition: Equatable {
        case car(Car)
        case otherCar
        case notCar

        static func == (lhs: Recognition, rhs: Recognition) -> Bool {
            switch (lhs, rhs) {
            case (let .car(carLHS), let .car(carRHS)):
                return carLHS == carRHS
            case (.otherCar, .otherCar):
                return true
            case (.notCar, .notCar):
                return true
            default:
                return false
            }
        }
    }

    let recognition: Recognition

    let confidence: Float

    /// Label returned by a model.
    let label: String

    /// Initializes the object from given parameters
    ///
    /// - Parameters:
    ///   - label: Label received from model
    ///   - confidence: Confidence received from model
    ///   - carsDataService: Data Service with cars
    init?(label: String, confidence: Float, carsDataService: CarsDataService) {
        self.confidence = confidence
        self.label = label
        if let car = carsDataService.map(classifierLabel: label) {
            recognition = .car(car)
        } else if label == Constants.Labels.Recognition.otherCar {
            recognition = .otherCar
        } else if label == Constants.Labels.Detection.notCar {
            recognition = .notCar
        } else {
            return nil
        }
    }

    /// SeeAlso: CustomStringConvertible
    var description: String {
        switch recognition {
        case .car(let car):
            return "\(car.model)\n(\(CRNumberFormatter.percentageFormatted(confidence)))"
        case .otherCar:
            return "other car\n(\(CRNumberFormatter.percentageFormatted(confidence)))"
        case .notCar:
            return "not car\n(\(CRNumberFormatter.percentageFormatted(confidence)))"
        }
    }
}

//
//  InputNormalizationService.swift
//  CarRecognition
//


internal final class InputNormalizationService {
    
    private let numberOfValuesToAverageCalculation: Int
    private lazy var normalizationValue = 1.0 / Double(numberOfValuesToAverageCalculation)
    private lazy var lastValues = [Double](repeating: 0.0, count: numberOfValuesToAverageCalculation)
    
    /// Initializes the normalizer
    ///
    /// - Parameter numberOfValues: Number of last saved values that will be used for normalization. Must be greater than 0.
    init(numberOfValues: Int) {
        guard numberOfValues > 0 else {
            fatalError("Cannot initialize normalizer with value \(numberOfValues). It must be greater than 0")
        }
        self.numberOfValuesToAverageCalculation = numberOfValues
    }
    
    /// Normalizes given value
    ///
    /// - Parameter value: Value to be normalized
    /// - Returns: Normalized value
    func normalize(value: Double) -> Double {
        lastValues.insert(value, at: 0)
        lastValues.removeLast()
        
        var average = 0.0
        lastValues.forEach { average += $0 * normalizationValue }
        return average
    }
    
    /// Normalizes given value
    ///
    /// - Parameter recognition: Recognition Result to be normalized
    /// - Returns: Normalized confidence value
    func normalizeConfidence(from recognitionResult: RecognitionResult) -> Double {
        let confidenceForNormalization: Double
        if case RecognitionResult.Recognition.notCar = recognitionResult.recognition {
            confidenceForNormalization = 0
        } else {
            confidenceForNormalization = Double(recognitionResult.confidence)
        }
        return normalize(value: confidenceForNormalization)
    }
    
    /// Resets the normalizer
    func reset() {
        lastValues = [Double](repeating: 0.0, count: numberOfValuesToAverageCalculation)
    }
}

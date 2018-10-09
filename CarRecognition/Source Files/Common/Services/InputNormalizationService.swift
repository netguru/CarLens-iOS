//
//  InputNormalizationService.swift
//  CarRecognition
//


internal final class InputNormalizationService {
    
    /// Number of recognition results needed for normalization to begin.
    private let numberOfValuesNeeded: Int
    
    /// Storage of recognition results to be normalized.
    private var recognitionResults: [RecognitionResult] = []
    
    private let carsDataService: CarsDataService
    
    /// Initializes the normalizer
    ///
    /// - Parameters:
    ///   - numberOfValues: Number of last saved values that will be used for normalization. Must be greater than 0.
    ///   - carsDataService: Data Service with cars.
    init(numberOfValues: Int, carsDataService: CarsDataService) {
        guard numberOfValues > 0 else {
            fatalError("Cannot initialize normalizer with value \(numberOfValues). It must be greater than 0")
        }
        self.numberOfValuesNeeded = numberOfValues
        self.carsDataService = carsDataService
    }
    
    /// Normalizes given value.
    ///
    /// - Parameter recognitionData: Recognition Results to be normalized.
    /// - Returns: Normalized RecognitionResult value.
    func normalizeConfidence(from recognitionData: [RecognitionResult]) -> RecognitionResult? {
        let sortedResults = recognitionData.sorted(by: { $0.confidence > $1.confidence })
        let resultsNumberNeeded = numberOfValuesNeeded - recognitionResults.count
        let resultsNeeded = sortedResults.prefix(resultsNumberNeeded)
        recognitionResults.append(contentsOf: resultsNeeded)
        guard recognitionResults.count == numberOfValuesNeeded else { return nil }
        let averageConfidencesForEachLabel: [String: Float] = dictionaryWithValuesSum(from: recognitionResults).mapValues { countAverage($0) }
        guard let bestResult = averageConfidencesForEachLabel.max(by: { $0.value < $1.value }) else { return nil }
        return RecognitionResult(label: bestResult.0, confidence: bestResult.1, carsDataService: carsDataService)
    }
    
    /// Resets the normalizer.
    func reset() {
        recognitionResults = []
    }
    
    private func dictionaryWithValuesSum(from recognitionResults: [RecognitionResult]) -> [String: [Float]] {
        return recognitionResults.reduce(into: [:]) { (counts, result) in
            counts[result.label, default: []].append(result.confidence)
        }
    }
    
    private func countAverage(_ array: [Float]) -> Float {
        return array.reduce(0, {$0 + $1}) / Float(array.count)
    }
}

//
//  InputNormalizationService.swift
//  CarRecognition
//


internal final class InputNormalizationService {
    
    /// Number of recognition results needed for normalization to begin.
    private let numberOfValuesNeeded: Int
    
    /// Storage of recognition results to be normilized.
    private var recognitionResults: [RecognitionResult] = []
    
    /// Indicating whether is ready for performing normalization.
    private var isReadyToNormalize: Bool {
        return recognitionResults.count == numberOfValuesNeeded
    }
    
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
        let resultsNumberNeeded = numberOfValuesNeeded - self.recognitionResults.count
        let resultsNeeded = recognitionData.prefix(resultsNumberNeeded)
        let sortedResults = resultsNeeded.sorted(by: { $0.confidence > $1.confidence })
        self.recognitionResults.append(contentsOf: sortedResults)
        guard isReadyToNormalize else { return nil }
        let sumOfConfidencesForEachLabel: [String: [Float]] = recognitionResults.reduce(into: [:]) { (counts, result) in
                                                counts[result.label, default: []].append(result.confidence)
                                            }
        let averageConfidencesForEachLabel: [String: Float] = sumOfConfidencesForEachLabel.mapValues {
                                                $0.reduce(0, {$0 + $1}) / Float($0.count)
                                            }
        guard let bestResult = averageConfidencesForEachLabel.max(by: { $0.value < $1.value }) else { return nil }
        return RecognitionResult(label: bestResult.0, confidence: bestResult.1, carsDataService: carsDataService)
    }
    
    /// Resets the normalizer.
    func reset() {
        recognitionResults = []
    }
}

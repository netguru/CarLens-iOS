//
//  CarRecognizerService.swift
//  CarRecognition
//

import CoreML
import Vision
import UIKit.UIImage

internal final class CarClassificationService {
    
    private let carsDataService: CarsDataService
    
    /// Available states of the service
    enum State {
        case running
        case paused
    }
    
    /// Completion handler for recognized cars
    var completionHandler: (([RecognitionResult]) -> ())?
    
    /// Indicates if recognizer is ready to analyze next frame
    var isReadyForNextFrame: Bool {
        return currentBuffer == nil
    }
    
    /// Initializes the object with given parameters
    ///
    /// - Parameter carsDataService: DataService with avialable cars
    init(carsDataService: CarsDataService) {
        self.carsDataService = carsDataService
    }
    
    /// Current state of the service
    private(set) var state: State = .running
    
    private var currentBuffer: CVPixelBuffer?
    
    private lazy var request: VNCoreMLRequest = { [unowned self] in
        guard let model = try? VNCoreMLModel(for: CarRecognitionModel().model) else {
            fatalError("Core ML model initialization failed")
        }
        let request = VNCoreMLRequest(model: model, completionHandler: { [weak self] request, error in
            self?.handleDetection(request: request, error: error)
        })
        request.imageCropAndScaleOption = .centerCrop
        return request
    }()
    
    /// Perform ML analyze on given buffer. Will do the analyze only when finished last one.
    ///
    /// - Parameter pixelBuffer: Pixel buffer to be analyzed
    func perform(on pixelBuffer: CVPixelBuffer) {
        guard state == .running, isReadyForNextFrame else { return }
        self.currentBuffer = pixelBuffer
        let orientation = CGImagePropertyOrientation.right
        let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: orientation, options: [:])
        DispatchQueue.global(qos: .userInitiated).async {
            defer { self.currentBuffer = nil }
            try? handler.perform([self.request])
        }
    }
    
    /// Updates the state of service
    ///
    /// - Parameter state: State to be set
    func set(state: State) {
        self.state = state
    }
    
    private func handleDetection(request: VNRequest, error: Error?) {
        guard
            let results = request.results,
            let classifications = results as? [VNClassificationObservation]
        else {
            return
        }
        let recognitionResult = classifications.compactMap { RecognitionResult(label: $0.identifier, confidence: $0.confidence, carsDataService: carsDataService) }
        completionHandler?(recognitionResult)
    }
}

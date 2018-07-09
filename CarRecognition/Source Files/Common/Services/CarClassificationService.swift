//
//  CarRecognizerService.swift
//  CarRecognition
//

import CoreML
import Vision
import UIKit.UIImage

internal final class CarClassificationService {
    
    /// Completion handler for recognized cars
    var completionHandler: ((CarClassifierResponse) -> ())?
    
    /// Indicates if recognizer is ready to analyze next frame
    var isReadyForNextFrame: Bool {
        return currentBuffer == nil
    }
    
    /// Value contains last recognized cars
    var lastTopRecognition: CarClassifierResponse?
    
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
        guard isReadyForNextFrame else { return }
        self.currentBuffer = pixelBuffer
        let orientation = CGImagePropertyOrientation.right
        let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: orientation, options: [:])
        DispatchQueue.global(qos: .userInitiated).async {
            defer { self.currentBuffer = nil }
            try? handler.perform([self.request])
        }
    }
    
    private func handleDetection(request: VNRequest, error: Error?) {
        guard
            let results = request.results,
            let classifications = results as? [VNClassificationObservation]
        else {
            return
        }
        let recognizedCars = classifications.compactMap { RecognitionResult(label: $0.identifier, confidence: $0.confidence) }
        let response = CarClassifierResponse(cars: recognizedCars)
        lastTopRecognition = response
        completionHandler?(response)
    }
}

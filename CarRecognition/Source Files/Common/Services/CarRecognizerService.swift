//
//  CarRecognizerService.swift
//  CarRecognition
//

import CoreML
import Vision
import UIKit.UIDevice

internal final class CarRecognizerService {
    
    private let completionHandler: ([RecognizedCar]) -> ()
    
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
    
    /// Indicates if recognizer is ready to analyze next frame
    var isReadyForNextFrame: Bool {
        return currentBuffer == nil
    }
    
    /// Initialize the recognizer
    ///
    /// - Parameter completionHandler: Handler that will be invoked after detection
    init(completionHandler: @escaping ([RecognizedCar]) -> ()) {
        self.completionHandler = completionHandler
    }

    func perform(on pixelBuffer: CVPixelBuffer) {
        guard isReadyForNextFrame else { return }
        self.currentBuffer = pixelBuffer
        let orientation = CGImagePropertyOrientation.right
        let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: orientation, options: [:])
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                defer { self.currentBuffer = nil }
                try handler.perform([self.request])
            } catch {
                print("Vision request failed with error \"\(error)\"")
            }
        }
    }
    
    private func handleDetection(request: VNRequest, error: Error?) {
        guard let results = request.results else {
            print("Unable to classify image, error: \(String(describing: error?.localizedDescription))")
            return
        }
        let classifications = results as! [VNClassificationObservation]
        let rocognizedCars = classifications.map { RecognizedCar(car: $0.identifier, confidence: $0.confidence) }
        DispatchQueue.main.async {
            self.completionHandler(rocognizedCars)
        }
    }
}

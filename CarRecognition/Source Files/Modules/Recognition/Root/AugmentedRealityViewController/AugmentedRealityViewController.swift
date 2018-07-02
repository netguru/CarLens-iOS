//
//  AugmentedRealityViewController.swift
//  CarRecognition
//


import UIKit
import SpriteKit
import ARKit

internal final class AugmentedRealityViewController: TypedViewController<AugmentedRealityView>, ARSessionDelegate, ARSKViewDelegate {
    
    /// Possiblle errors that can occur during applying AR labels
    enum CarARLabelError: Error {
        case hitTestFailed
        case noRecentFrameFound
    }
    /// Callback called when new augemented reality frame was captured
    var didCapturedARFrame: ((ARFrame) -> ())?
    
    private var nodeShift: NodeShift {
        #if ENV_DEVELOPMENT
            return NodeShift(depth: 0, elevation: 0)
        #else
            return NodeShift(depth: 1, elevation: 1)
        #endif
    }
    
    private var minimumDistanceFromDevice: CGFloat {
        #if ENV_DEVELOPMENT
            return 0.1
        #else
            return 0.5
        #endif
    }
    
    private let pointForHitTest = CGPoint(x: 0.5, y: 0.5)
    
    private let neededConfidenceToPinLabel: Double = 0.99
    
    private var addedAnchors: [ARAnchor: RecognitionResult] = [:]
    
    private let inputNormalizationService = InputNormalizationService(numberOfValues: 30)
    
    /// SeeAlso: UIViewController
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupSession()
    }
    
    /// SeeAlso: UIViewController
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        customView.previewView.session.pause()
    }
    
    /// SeeAlso: UIViewController
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        customView.sceneView.size = customView.previewView.bounds.size
    }
    
    /// Handles results of the classification
    ///
    /// - Parameter result: Classification result
    func handleRecognition(result: CarClassifierResponse, errorHandler: ((CarARLabelError) -> ())? = nil) {
        guard let mostConfidentRecognition = result.cars.first else { return }
        let normalizedConfidence = inputNormalizationService.normalize(value: Double(mostConfidentRecognition.confidence))
        customView.detectionViewfinderView.update(progress: CGFloat(normalizedConfidence))
        handlePinAddingIfNeeded(for: mostConfidentRecognition, normalizedConfidence: normalizedConfidence, errorHandler: errorHandler)
    }
    
    private func handlePinAddingIfNeeded(for result: RecognitionResult, normalizedConfidence: Double, errorHandler: ((CarARLabelError) -> ())? = nil) {
        guard
            normalizedConfidence >= neededConfidenceToPinLabel,
            !addedAnchors.contains(where: { $0.value == result})
        else { return }
        let hitTests = customView.previewView.hitTest(pointForHitTest, types: [.featurePoint])
        guard let possibleCarHit = hitTests.first(where: { $0.distance > minimumDistanceFromDevice }) else {
            errorHandler?(.hitTestFailed)
            return
        }
        guard let lastCapturedFrame = customView.previewView.session.currentFrame else {
            errorHandler?(.noRecentFrameFound)
            return
        }
        var translation = matrix_identity_float4x4
        translation.columns.3.z = Float(-possibleCarHit.distance) - nodeShift.depth
        translation.columns.3.x = -nodeShift.elevation
        let transform = simd_mul(lastCapturedFrame.camera.transform, translation)
        let anchor = ARAnchor(transform: transform)
        addedAnchors[anchor] = result
        customView.previewView.session.add(anchor: anchor)
    }
    
    private func setupSession() {
        customView.previewView.delegate = self
        customView.previewView.session.delegate = self
        
        let configuration = ARWorldTrackingConfiguration()
        if #available(iOS 11.3, *) {
            configuration.planeDetection = [.vertical]
            configuration.isAutoFocusEnabled = true
        }
        customView.previewView.session.run(configuration)
    }
    
    
    
    
    
    
    
//    func handleRecognition(result: CarClassifierResponse, errorHandler: ((CarARLabelError) -> ())? = nil) {
//        guard let mostConfidentRecognition = result.cars.first else { return }
//        handleViewfinder(for: mostConfidentRecognition, errorHandler: errorHandler)
//        handlePinAddingIfNeeded(for: mostConfidentRecognition, errorHandler: errorHandler)
//    }
//
//    private func handleViewfinder(for result: RecognitionResult, errorHandler: ((CarARLabelError) -> ())? = nil) {
//        let normalizedConfidence = inputNormalizationService.normalize(value: Double(result.confidence))
//        customView.detectionViewfinderView.update(progress: CGFloat(normalizedConfidence))
//    }
//

    
    
    
    
    
    
    
    
    
    /// SeeAlso: ARSessionDelegate
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        didCapturedARFrame?(frame)
    }

    /// SeeAlso: ARSKViewDelegate
    func view(_ view: ARSKView, nodeFor anchor: ARAnchor) -> SKNode? {
        guard let element = addedAnchors[anchor] else { return nil }
        guard case let Car.known(_, model) = element.car else { return nil }
        return SKNodeFactory.car(labeled: model.capitalized)
    }
}

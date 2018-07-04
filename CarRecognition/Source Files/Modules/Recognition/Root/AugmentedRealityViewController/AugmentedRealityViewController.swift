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
        case pinAlreadyAdded
        case hitTestFailed
        case hitTestTooClose
        case hitTestTooFar
        case noRecentFrameFound
    }
    /// Callback called when new augemented reality frame was captured
    var didCapturedARFrame: ((ARFrame) -> ())?
    
    private let config = CarARConfiguration()
    
    private var addedAnchors: [ARAnchor: RecognitionResult] = [:]
    
    private var cardDidSlideIn = false
    
    private lazy var inputNormalizationService = InputNormalizationService(numberOfValues: config.normalizationCount)
    
    /// SeeAlso: UIViewController
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        setupSession()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // change 2 to desired number of seconds
            self.handleCardSlidingIfNeeded(normalizedConfidence: 1.0)
        }
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
        try? customView.detectionViewfinderView.update(state: .recognizing(progress: normalizedConfidence))
        handlePinAddingIfNeeded(for: mostConfidentRecognition, normalizedConfidence: normalizedConfidence, errorHandler: errorHandler)
        handleCardSlidingIfNeeded(normalizedConfidence: normalizedConfidence)
    }
    
    private func handlePinAddingIfNeeded(for result: RecognitionResult, normalizedConfidence: Double, errorHandler: ((CarARLabelError) -> ())? = nil) {
        guard normalizedConfidence >= config.neededConfidenceToPinLabel else { return }
        let hitTests = customView.previewView.hitTest(config.pointForHitTest, types: [.featurePoint])
        guard hitTests.count > 0 else {
            errorHandler?(.hitTestFailed)
            return
        }
        guard let possibleCarHit = hitTests.first(where: { $0.distance > config.minimumDistanceFromDevice }) else {
            errorHandler?(.hitTestTooClose)
            return
        }
        guard possibleCarHit.distance < config.maximumDistanceFromDevice else {
            errorHandler?(.hitTestTooFar)
            return
        }
        guard let lastCapturedFrame = customView.previewView.session.currentFrame else {
            errorHandler?(.noRecentFrameFound)
            return
        }
        let anchor = ARAnchor(from: possibleCarHit, camera: lastCapturedFrame.camera, nodeShift: config.nodeShift)
        if shouldAdd(anchor: anchor) {
            addedAnchors[anchor] = result
            customView.previewView.session.add(anchor: anchor)
        } else {
            errorHandler?(.pinAlreadyAdded)
        }
    }
    
    private func handleCardSlidingIfNeeded(normalizedConfidence: Double) {
        guard normalizedConfidence >= config.neededConfidenceToPinLabel else { return }
        
        let carCardView = CarCardViewController(viewMaker: CarCardView())
        
        // 2- Add bottomSheetVC as a child view
        addChildViewController(carCardView)
        view.addSubview(carCardView.view)
        carCardView.didMove(toParentViewController: self)
        
        // 3- Adjust bottomSheet frame and initial position.
        guard !cardDidSlideIn else { return }
        
        cardDidSlideIn = true

        let height = UIScreen.main.bounds.height / 2
        let width  = UIScreen.main.bounds.width
        
        carCardView.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.maxY + height, width: width, height: height)
        
        carCardView.setupAnimation()
    }
    
    /// Checks if new node at given anchor could be added.
    /// It shouldn't allow adding two anchors too close to each other.
    ///
    /// - Parameter anchor: Proposed anchor to add
    /// - Returns: Boolean indicating if new node can be addded
    private func shouldAdd(anchor: ARAnchor) -> Bool {
        for existingAnchor in addedAnchors.keys {
            if existingAnchor.distance(from: anchor) < config.minimumDistanceBetweenNodes {
                return false
            }
        }
        return true
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

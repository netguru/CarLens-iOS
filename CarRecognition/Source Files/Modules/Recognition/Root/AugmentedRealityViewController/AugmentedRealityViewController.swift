//
//  AugmentedRealityViewController.swift
//  CarRecognition
//


import UIKit
import SpriteKit
import ARKit

internal final class AugmentedRealityViewController: TypedViewController<AugmentedRealityView>, ARSessionDelegate, ARSKViewDelegate {
    
    /// Possiblle errors that can occur during applying AR labels
    enum CarARLabelError: String, Error {
        case pinAlreadyAdded
        case hitTestFailed
        case hitTestTooClose
        case hitTestTooFar
        case noRecentFrameFound
    }
    /// Callback called when new augemented reality frame was captured
    var didCapturedARFrame: ((ARFrame) -> ())?
    
    private let config = CarARConfiguration()
    
    private var addedAnchors: [ARAnchor: Car] = [:]
    
    private var cardDidSlideIn = false
    
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
    
    /// Updates the detection viewfinder with given progress
    ///
    /// - Parameter progress: Progress to be set
    func updateDetectionViewfinder(to state: DetectionViewfinderView.State) throws {
        try customView.detectionViewfinderView.update(state: state)
    }
    
    /// Tries to add augmented reality pin to the car in 3D world
    ///
    /// - Parameters:
    ///   - car: Car to be pinned
    ///   - completion: Completion handler called when pin was successfully addded
    ///   - error: Error handler called when error occurred during pin adding
    func addPin(to car: Car, completion: (Car) -> (), error: ((CarARLabelError) -> ())? = nil) {
        let hitTests = customView.previewView.hitTest(config.pointForHitTest, types: [.featurePoint])
        guard hitTests.count > 0 else {
            error?(.hitTestFailed)
            return
        }
        guard let possibleCarHit = hitTests.first(where: { $0.distance > config.minimumDistanceFromDevice }) else {
            error?(.hitTestTooClose)
            return
        }
        guard possibleCarHit.distance < config.maximumDistanceFromDevice else {
            error?(.hitTestTooFar)
            return
        }
        guard let lastCapturedFrame = customView.previewView.session.currentFrame else {
            error?(.noRecentFrameFound)
            return
        }
        let anchor = ARAnchor(from: possibleCarHit, camera: lastCapturedFrame.camera, nodeShift: config.nodeShift)
        if shouldAdd(anchor: anchor) {
            addedAnchors[anchor] = car
            customView.previewView.session.add(anchor: anchor)
            completion(car)
        } else {
            error?(.pinAlreadyAdded)
        }
    }
    
    /// Handle card sliding based on recognition status
    ///
    /// - Parameter normalizedConfidence: Value between 0 and 1 indicating the status of recognition
    private func handleCardSlidingIfNeeded(normalizedConfidence: Double) {
        guard normalizedConfidence >= config.neededConfidenceToPinLabel, !cardDidSlideIn else {
            return
        }
        /// TEMP: - Just a temporary Volkswagen Passat that will be changed by the detected car in the future
        let car = Car.known(make: .volkswagen, model: "passat")
        let carCardView = CarCardViewController(viewMaker: CarCardView(car: car))

        addChildViewController(carCardView)
        view.addSubview(carCardView.view)
        carCardView.didMove(toParentViewController: self)

        let height = UIScreen.main.bounds.height / 2
        let width  = UIScreen.main.bounds.width

        carCardView.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.maxY + height, width: width, height: height)
        carCardView.animateIn()
        cardDidSlideIn = true
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
        guard case let Car.known(_, model) = element else { return nil }
        return SKNodeFactory.car(labeled: model.capitalized)
    }
}

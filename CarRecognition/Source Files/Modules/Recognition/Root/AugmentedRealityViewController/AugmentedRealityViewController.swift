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
    
    /// Callback called when user tapped AR pin with given car id
    var didTapCar: ((String) -> ())?
    
    /// Callback called when user tapped the view excluding the AR pin
    var didTapBackgroundView: (() -> ())?
    
    private let config = CarARConfiguration()
    
    private var addedAnchors: [ARAnchor: Car] = [:]
    
    /// SeeAlso: UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNotifications()
        customView.sceneView.didTapCar = { [unowned self] id in
            self.didTapCar?(id)
        }
        
        customView.sceneView.didTapBackgroundView = { [unowned self] in
            self.didTapBackgroundView?()
        }
    }
    
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
    
    /// Updates the detection viewfinder with given state
    ///
    /// - Parameter result: Result to be set
    func updateDetectionViewfinder(to result: RecognitionResult, normalizedConfidence: Double) {
        customView.detectionViewfinderView.update(to: result, normalizedConfidence: normalizedConfidence)
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
    
    private func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillEnterBackground), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(cameraIsReadyToRecord), name: NSNotification.Name.AVCaptureSessionDidStartRunning, object: nil)
    }
    
    @objc private func cameraIsReadyToRecord() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [unowned self] in
            self.customView.blurEffectView.isHidden = true
        }
    }
    
    @objc private func applicationWillEnterBackground() {
        customView.blurEffectView.isHidden = false
    }
    
    /// SeeAlso: ARSessionDelegate
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        didCapturedARFrame?(frame)
    }

    /// SeeAlso: ARSKViewDelegate
    func view(_ view: ARSKView, nodeFor anchor: ARAnchor) -> SKNode? {
        guard let car = addedAnchors[anchor] else { return nil }
        return SKNodeFactory().node(for: car)
    }
}

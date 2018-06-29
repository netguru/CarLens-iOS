//
//  AugmentedRealityViewController.swift
//  CarRecognition
//


import UIKit
import SpriteKit
import ARKit

internal final class AugmentedRealityViewController: TypedViewController<AugmentedRealityView>, ARSessionDelegate, ARSKViewDelegate {
    
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
    
    private let neededConfidenceToPinLabel: Float = 0.99
    
    private var addedAnchors: [ARAnchor: RecognizedCar] = [:]
    
    /// Callback called when new augemented reality frame was captured
    var didCapturedARFrame: ((ARFrame) -> ())?
    
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
    func handleRecognition(result: CarClassifierResponse) {
        guard
            let mostConfidentRecognition = result.cars.first,
            mostConfidentRecognition.car != "not car",
            mostConfidentRecognition.confidence >= neededConfidenceToPinLabel,
            !addedAnchors.contains(where: { $0.value == mostConfidentRecognition})
        else {
            return
        }
        let hitTests = customView.previewView.hitTest(pointForHitTest, types: [.featurePoint])
        guard let possibleCarHit = hitTests.first(where: { $0.distance > minimumDistanceFromDevice }) else {
            print("Hit test failed or detected object is to close to the phone")
            return
        }
        guard let lastCapturedFrame = customView.previewView.session.currentFrame else {
            print("No recent AR frame found")
            return
        }
        var translation = matrix_identity_float4x4
        translation.columns.3.z = Float(-possibleCarHit.distance) - nodeShift.depth
        translation.columns.3.x = -nodeShift.elevation
        let transform = simd_mul(lastCapturedFrame.camera.transform, translation)
        let anchor = ARAnchor(transform: transform)
        addedAnchors[anchor] = mostConfidentRecognition
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
    
    /// SeeAlso: ARSessionDelegate
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        didCapturedARFrame?(frame)
    }

    /// SeeAlso: ARSKViewDelegate
    func view(_ view: ARSKView, nodeFor anchor: ARAnchor) -> SKNode? {
        guard let model = addedAnchors[anchor] else { return nil }
        return SKNodeFactory.car(labeled: model.splittedModelName)
    }
}

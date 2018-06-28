//
//  LiveVideoViewController.swift
//  CarRecognition
//


import UIKit
import SpriteKit
import ARKit

internal final class LiveVideoViewController: TypedViewController<LiveVideoView>, ARSessionDelegate, ARSKViewDelegate {
    
    private let classificationService = CarClassificationService()
    
    private var addedAnchors: [ARAnchor: RecognizedCar] = [:]
    
    /// SeeAlso: UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.checkDetailsButton.addTarget(self, action: #selector(didTapCheckDetailsButton), for: .touchUpInside)
        classificationService.completionHandler = { [weak self] result in
            self?.handleRecognition(result: result)
            self?.handleRecognitionInAR(result: result)
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
    
    private func handleRecognition(result: CarClassifierResponse) {
        customView.analyzeTimeLabel.text = CRTimeFormatter.intervalMilisecondsFormatted(result.analyzeDuration)
        
        let labels = [customView.modelFirstLabel, customView.modelSecondLabel, customView.modelThirdLabel]
        for (index, element) in result.cars.prefix(3).enumerated() {
            labels[index].text = element.descriptionWithConfidence
        }
    }
    
    private func handleRecognitionInAR(result: CarClassifierResponse) {
        guard
            let mostConfidentRecognition = result.cars.first,
            mostConfidentRecognition.car != "not car",
            mostConfidentRecognition.confidence >= 0.99,
            !addedAnchors.contains(where: { $0.value == mostConfidentRecognition})
        else {
            return
        }
        let hitTests = customView.previewView.hitTest(CGPoint(x: 0.5, y: 0.5), types: [.featurePoint])
        guard let possibleCarHit = hitTests.first(where: { $0.distance > 0.1 }) else {
            print("Hit test failed or detected object is to close to the phone")
            return
        }
        guard let lastCapturedFrame = customView.previewView.session.currentFrame else {
            print("No recent AR frame found")
            return
        }
        var translation = matrix_identity_float4x4
        translation.columns.3.z = Float(-possibleCarHit.distance) - 1 // - 1 to put the label 1m inside the car
        translation.columns.3.x = -1 // -1 to put the label 1m above the car
        let transform = simd_mul(lastCapturedFrame.camera.transform, translation)
        let anchor = ARAnchor(transform: transform)
        addedAnchors[anchor] = mostConfidentRecognition
        customView.previewView.session.add(anchor: anchor)
    }
    
    @objc private func didTapCheckDetailsButton() {
        guard let lastRecognition = classificationService.lastTopRecognition else { return }
        let carDetailsViewController = CarTypeSearchViewController(recognizedCars: lastRecognition)
        navigationController?.pushViewController(carDetailsViewController, animated: true)
    }
    
    /// SeeAlso: ARSessionDelegate
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        classificationService.perform(on: frame.capturedImage)
    }
    
    /// SeeAlso: ARSKViewDelegate
    func view(_ view: ARSKView, nodeFor anchor: ARAnchor) -> SKNode? {
        guard let model = addedAnchors[anchor] else { return nil }
        let labelNode = SKLabelNode(text: model.car)
        labelNode.horizontalAlignmentMode = .center
        labelNode.verticalAlignmentMode = .center
        labelNode.fontName = UIFont.boldSystemFont(ofSize: 70).fontName
        labelNode.fontSize = 10
        labelNode.fontColor = .red
        return labelNode
    }
}

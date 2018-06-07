//
//  LiveVideoViewController.swift
//  CarRecognition
//


import UIKit
import SpriteKit
import ARKit

internal final class LiveVideoViewController: TypedViewController<LiveVideoView>, ARSKViewDelegate, ARSessionDelegate {
    
    private lazy var carRecognizerService = CarRecognizerService(completionHandler: { [weak self] result in
        self?.handleRecognition(result: result)
    })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.sceneView.delegate = self
        customView.sceneView.session.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        customView.sceneView.session.run(ARWorldTrackingConfiguration())
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        customView.sceneView.session.pause()
    }
    
    private func handleRecognition(result: [RecognizedCar]) {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        
        let highConfidence = result.filter { $0.confidence > 0.9 }
        
        guard let first = highConfidence.first, let percentageConfidence = numberFormatter.string(from: NSNumber(value: first.confidence)) else { return }
        
        customView.modelLabel.text = "\(first.car) (\(percentageConfidence))\nTotal detected above 90%: \(highConfidence.count)"
    }
    
    /// SeeAlso: ARSessionDelegate
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        carRecognizerService.perform(on: frame.capturedImage)
    }
}

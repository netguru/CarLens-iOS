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
        
        customView.sceneView.session.run(AROrientationTrackingConfiguration())
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        customView.sceneView.session.pause()
    }
    
    private func handleRecognition(result: [RecognizedCar]) {
        guard let first = result.first else { return }
        if first.confidence > 0.6 {
            customView.modelLabel.text = "\(first.car)\n(\(CRNumberFormatter.percentageFormatted(first.confidence)))"
        } else {
            customView.modelLabel.text = ""
        }
    }
    
    /// SeeAlso: ARSessionDelegate
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        carRecognizerService.perform(on: frame.capturedImage)
    }
}

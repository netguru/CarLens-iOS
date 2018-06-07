//
//  LiveVideoViewController.swift
//  CarRecognition
//


import UIKit
import SpriteKit
import ARKit

internal final class LiveVideoViewController: TypedViewController<LiveVideoView>, ARSKViewDelegate, ARSessionDelegate {
    
    private let carRecognizerService = CarRecognizerService(completionHandler: { result in
        print("VC Detection result: \(result)")
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
}

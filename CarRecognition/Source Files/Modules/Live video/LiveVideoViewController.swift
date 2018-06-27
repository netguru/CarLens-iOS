//
//  LiveVideoViewController.swift
//  CarRecognition
//


import UIKit
import SpriteKit
import ARKit

internal final class LiveVideoViewController: TypedViewController<LiveVideoView>, ARSessionDelegate {
    
    private let classificationService = CarClassificationService()
    
    /// SeeAlso: UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.checkDetailsButton.addTarget(self, action: #selector(didTapCheckDetailsButton), for: .touchUpInside)
        classificationService.completionHandler = { [weak self] result in
            self?.handleRecognition(result: result)
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
        customView.previewView.session.delegate = self
        
        let configuration = ARWorldTrackingConfiguration()
        if #available(iOS 11.3, *) {
            configuration.isAutoFocusEnabled = true
        }
        customView.previewView.session.run(configuration)
    }
    
    private func handleRecognition(result: CarRecognizeResponse) {
        customView.analyzeTimeLabel.text = CRTimeFormatter.intervalMilisecondsFormatted(result.analyzeDuration)
        
        let labels = [customView.modelFirstLabel, customView.modelSecondLabel, customView.modelThirdLabel]
        for (index, element) in result.cars.prefix(3).enumerated() {
            labels[index].text = "\(element.car)\n(\(CRNumberFormatter.percentageFormatted(element.confidence)))"
        }
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
}

//
//  RecognitionViewController.swift
//  CarRecognition
//


import UIKit
import SpriteKit
import ARKit

internal final class RecognitionViewController: TypedViewController<RecognitionView> {
    
    /// Enum describing events that can be triggered by this controller
    ///
    /// - didTapShowCarsList: send when user want to see the list of available cars
    enum Event {
        case didTapShowCarsList
    }
    
    /// Callback with triggered event
    var eventTriggered: ((Event) -> ())?
    
    private let classificationService: CarClassificationService
    
    private let augmentedRealityViewController: AugmentedRealityViewController
    
    private let arConfig = CarARConfiguration()
    
    private lazy var inputNormalizationService = InputNormalizationService(numberOfValues: arConfig.normalizationCount)
    
    /// Initializes view controller with given dependencies
    ///
    /// - Parameters:
    ///   - augmentedRealityViewController: View controller with AR live preview
    ///   - classificationService: Classification service used to recognize objects
    init(augmentedRealityViewController: AugmentedRealityViewController, classificationService: CarClassificationService) {
        self.augmentedRealityViewController = augmentedRealityViewController
        self.classificationService = classificationService
        super.init(viewMaker: RecognitionView())
    }
    
    /// SeeAlso: UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.carsListButton.addTarget(self, action: #selector(carsListButtonTapAction), for: .touchUpInside)
        augmentedRealityViewController.didCapturedARFrame = { [weak self] frame in
            self?.classificationService.perform(on: frame.capturedImage)
        }
        classificationService.completionHandler = { [weak self] result in
            DispatchQueue.main.async {
                self?.handleRecognition(result: result)
            }
        }
    }
    
    /// - SeeAlso: UIViewController
    override func loadView() {
        super.loadView()
        add(augmentedRealityViewController, inside: customView.augmentedRealityContainer)
    }
    
    private func handleRecognition(result: CarClassifierResponse) {
        guard let mostConfidentRecognition = result.cars.first else { return }
        let normalizedConfidence = inputNormalizationService.normalize(value: Double(mostConfidentRecognition.confidence))
        try? augmentedRealityViewController.updateDetectionViewfinder(to: .recognizing(progress: normalizedConfidence))
        if normalizedConfidence >= arConfig.neededConfidenceToPinLabel {
            augmentedRealityViewController.addPin(to: mostConfidentRecognition.car, completion: { car in
                // TODO: Open bottom sheet for `car`
            }, error: { [unowned self] error in
                // TODO: Debug information, remove from final version
                self.customView.analyzeTimeLabel.text = error.rawValue
            })
        }
        
        // TODO: Debug information, remove from final version
        customView.detectedModelLabel.text = mostConfidentRecognition.car.description + " (\(CRNumberFormatter.percentageFormatted(Float(normalizedConfidence))))"
    }
    
    @objc private func carsListButtonTapAction() {
        eventTriggered?(.didTapShowCarsList)
    }
}

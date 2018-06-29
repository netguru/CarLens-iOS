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
    /// - didTapSelectModel: send when user want to select the specific model
    enum Event {
        case didTapSelectModel
    }
    
    /// Callback with triggered event
    var eventTriggered: ((Event) -> ())?
    
    private let classificationService: CarClassificationService
    
    private let augmentedRealityViewController: AugmentedRealityViewController
    
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
        customView.checkDetailsButton.addTarget(self, action: #selector(didTapCheckDetailsButton), for: .touchUpInside)
        augmentedRealityViewController.didCapturedARFrame = { [weak self] frame in
            self?.classificationService.perform(on: frame.capturedImage)
        }
        classificationService.completionHandler = { [weak self] result in
            self?.handleRecognition(result: result)
            self?.augmentedRealityViewController.handleRecognition(result: result)
        }
    }
    
    /// - SeeAlso: UIViewController
    override func loadView() {
        super.loadView()
        add(augmentedRealityViewController, inside: customView.augmentedRealityContainer)
    }
    
    private func handleRecognition(result: CarClassifierResponse) {
        customView.analyzeTimeLabel.text = CRTimeFormatter.intervalMilisecondsFormatted(result.analyzeDuration)
        
        let labels = [customView.modelFirstLabel, customView.modelSecondLabel, customView.modelThirdLabel]
        for (index, element) in result.cars.prefix(3).enumerated() {
            labels[index].text = element.descriptionWithConfidence
        }
    }
    
    @objc private func didTapCheckDetailsButton() {
        eventTriggered?(.didTapSelectModel)
    }
}

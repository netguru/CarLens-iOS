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
                self?.augmentedRealityViewController.handleRecognition(result: result)
            }
        }
    }
    
    /// - SeeAlso: UIViewController
    override func loadView() {
        super.loadView()
        add(augmentedRealityViewController, inside: customView.augmentedRealityContainer)
    }
    
    private func handleRecognition(result: CarClassifierResponse) {
        customView.analyzeTimeLabel.text = CRTimeFormatter.intervalMilisecondsFormatted(result.analyzeDuration)   
        customView.detectedModelLabel.text = result.cars.first?.description ?? ""
    }
    
    @objc private func carsListButtonTapAction() {
        eventTriggered?(.didTapShowCarsList)
    }
}

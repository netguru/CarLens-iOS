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
    
    private var carCardViewController: CarCardViewController?
    
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
            augmentedRealityViewController.addPin(to: mostConfidentRecognition.car, completion: { [unowned self] car in
                self.classificationService.set(state: .paused)
                self.addSlidingCard(with: car)
            }, error: { [unowned self] error in
                // TODO: Debug information, remove from final version
                self.customView.analyzeTimeLabel.text = error.rawValue
            })
        }
        
        // TODO: Debug information, remove from final version
        customView.detectedModelLabel.text = mostConfidentRecognition.car.description + " (\(CRNumberFormatter.percentageFormatted(Float(normalizedConfidence))))"
    }
    
    private func addSlidingCard(with car: Car) {
        carCardViewController = CarCardViewController(viewMaker: CarCardView(car: car))
        guard let carCardViewController = carCardViewController else { return }
        setup(carCardViewController: carCardViewController)
        carCardViewController.animateIn()
    }
    
    private func setup(carCardViewController: CarCardViewController) {
        carCardViewController.didDismissView = { [unowned self] in
            self.classificationService.set(state: .running)
            self.carCardViewController = nil
        }
        
        addChildViewController(carCardViewController)
        view.addSubview(carCardViewController.view)
        carCardViewController.didMove(toParentViewController: self)
        
        let height = UIScreen.main.bounds.height / 2
        let width  = UIScreen.main.bounds.width
        
        carCardViewController.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.maxY + height, width: width, height: height)
    }
    
    @objc private func carsListButtonTapAction() {
        eventTriggered?(.didTapShowCarsList)
    }
}

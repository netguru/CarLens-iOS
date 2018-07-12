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
    /// - didTriggerShowCarsList: Send when user should see the list of available cars passing car if any is displayed be the bottom sheet.
    /// - didTriggerGoogleSearch: Send when user should open Safari with google searching for selected car.
    /// - didTriggerCameraAccessDenial: Send when user doesn't allow access for camera
    enum Event {
        case didTriggerShowCarsList(Car?)
        case didTriggerGoogleSearch(Car)
        case didTriggerCameraAccessDenial
    }
    
    /// Callback with triggered event
    var eventTriggered: ((Event) -> ())?
    
    /// See also 'UIViewController'
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private let classificationService: CarClassificationService
    
    private let augmentedRealityViewController: AugmentedRealityViewController
    
    private var carCardViewController: CarCardViewController?
    
    private let carsDataService: CarsDataService
    
    private let arConfig = CarARConfiguration()
    
    private lazy var inputNormalizationService = InputNormalizationService(numberOfValues: arConfig.normalizationCount)
    
    /// Initializes view controller with given dependencies
    ///
    /// - Parameters:
    ///   - augmentedRealityViewController: View controller with AR live preview
    ///   - classificationService: Classification service used to recognize objects
    ///   - carsDataService: Data service for retrieving informations about cars
    init(augmentedRealityViewController: AugmentedRealityViewController, classificationService: CarClassificationService, carsDataService: CarsDataService) {
        self.augmentedRealityViewController = augmentedRealityViewController
        self.classificationService = classificationService
        self.carsDataService = carsDataService
        super.init(viewMaker: RecognitionView())
    }
    
    /// SeeAlso: UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.carsListButton.addTarget(self, action: #selector(carsListButtonTapAction), for: .touchUpInside)
        augmentedRealityViewController.didCapturedARFrame = { [weak self] frame in
            self?.classificationService.perform(on: frame.capturedImage)
        }
        augmentedRealityViewController.didTapCar = { [unowned self] id in
            guard let car = self.carsDataService.getAvailableCars().first(where: { $0.id == id }) else { return }
            self.addSlidingCard(with: car)
        }
        classificationService.completionHandler = { [weak self] result in
            DispatchQueue.main.async {
                self?.handleRecognition(result: result)
            }
        }
    }
    
    /// SeeAlso: UIViewController
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkCameraAccess()
    }
    
    /// - SeeAlso: UIViewController
    override func loadView() {
        super.loadView()
        add(augmentedRealityViewController, inside: customView.augmentedRealityContainer)
    }
    
    private func handleRecognition(result: [RecognitionResult]) {
        guard let mostConfidentRecognition = result.first else { return }
        let normalizedConfidence = inputNormalizationService.normalizeConfidence(from: mostConfidentRecognition)
        augmentedRealityViewController.updateDetectionViewfinder(to: mostConfidentRecognition, normalizedConfidence: normalizedConfidence)
        switch mostConfidentRecognition.recognition {
        case .car(let car):
            augmentedRealityViewController.updateDetectionViewfinder(to: mostConfidentRecognition, normalizedConfidence: normalizedConfidence)
            if normalizedConfidence >= arConfig.neededConfidenceToPinLabel {
                augmentedRealityViewController.addPin(to: car, completion: { [unowned self] car in
                    self.classificationService.set(state: .paused)
                    self.addSlidingCard(with: car)
                    self.carsDataService.mark(car: car, asDiscovered: true)
                }, error: { [unowned self] error in
                    // TODO: Debug information, remove from final version
                    self.customView.analyzeTimeLabel.text = error.rawValue
                })
            }
        case .otherCar, .notCar:
            break
        }
        
        // TODO: Debug information, remove from final version
        customView.detectedModelLabel.text = mostConfidentRecognition.description
    }
    
    private func addSlidingCard(with car: Car) {
        carCardViewController = CarCardViewController(car: car)
        guard let carCardViewController = carCardViewController else { return }
        setup(carCardViewController: carCardViewController)
        carCardViewController.animateIn()
    }
    
    /// Removes car's card with animation
    internal func removeSlidingCard() {
        carCardViewController?.animateOut()
        carCardViewController?.view.removeFromSuperview()
        carCardViewController = nil
    }
    
    private func setup(carCardViewController: CarCardViewController) {
        carCardViewController.eventTriggered = { [unowned self] event in
            switch event {
            case .didTapCarsList(let car):
                self.eventTriggered?(.didTriggerShowCarsList(car))
            case .didTapSearchGoogle(let car):
                self.eventTriggered?(.didTriggerGoogleSearch(car))
            case .didDismissViewByScanButtonTap, .didDismissView:
                self.classificationService.set(state: .running)
                self.carCardViewController = nil
            }
        }
        addChildViewController(carCardViewController)
        view.addSubview(carCardViewController.view)
        carCardViewController.didMove(toParentViewController: self)
        
        let height: CGFloat = CarCardViewController.Constants.cardHeight
        let width  = UIScreen.main.bounds.width
        carCardViewController.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.maxY + height, width: width, height: height)
    }
    
    @objc private func carsListButtonTapAction() {
        eventTriggered?(.didTriggerShowCarsList(nil))
    }
    
    private func checkCameraAccess() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .denied, .restricted:
            eventTriggered?(.didTriggerCameraAccessDenial)
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [unowned self] success in
                if !success {
                    self.eventTriggered?(.didTriggerCameraAccessDenial)
                }
            }
        default:
            break
        }
    }
}

//
//  RecognitionViewController.swift
//  CarLens
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
    
    /// - SeeAlso: 'UIViewController'
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private let classificationService: CarClassificationService
    
    private let augmentedRealityViewController: AugmentedRealityViewController
    
    private var carCardViewController: CarCardViewController?
    
    private let carsDataService: CarsDataService
    
    private let arConfig = CarARConfiguration()
    
    private lazy var inputNormalizationService = InputNormalizationService(numberOfValues: Constants.Recognition.normalizationCount, carsDataService: carsDataService)
    
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
        setupView()
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
        view.accessibilityIdentifier = "recognition/view/main"
    }
    
    /// Removes car's card.
    /// - Parameter shouldAddAnimation: defines whether animate the removal of the card.
    func removeSlidingCard(shouldAddAnimation: Bool = true) {
        if shouldAddAnimation {
            carCardViewController?.animateOut()
        }
        carCardViewController?.view.removeFromSuperview()
        carCardViewController = nil
        customView.mode = .afterCardRemoval
    }
    
    private func setupView() {
        customView.carsListButton.addTarget(self, action: #selector(carsListButtonTapAction), for: .touchUpInside)
        customView.closeButton.addTarget(self, action: #selector(closeButtonTapAction), for: .touchUpInside)
        customView.scanButton.addTarget(self, action: #selector(scanButtonTapAction), for: .touchUpInside)
        augmentedRealityViewController.didCapturedARFrame = { [weak self] frame in
            self?.classificationService.perform(on: frame.capturedImage)
        }
        augmentedRealityViewController.didTapCar = { [unowned self] id in
            guard let car = self.carsDataService.getAvailableCars().first(where: { $0.id == id }) else { return }
            self.addSlidingCard(with: car)
        }
        augmentedRealityViewController.didTapBackgroundView = { [unowned self] in
            guard self.carCardViewController != nil else { return }
            self.removeSlidingCard()
        }
        classificationService.completionHandler = { [weak self] results in
            DispatchQueue.main.async {
                self?.handleRecognition(results: results)
            }
        }
    }
    
    private func handleRecognition(results: [RecognitionResult]) {
        guard let result = results.first else { return }
        var recognitionResult: RecognitionResult
        if result.recognition == .notCar {
            recognitionResult = result
            augmentedRealityViewController.updateDetectionViewfinder(to: recognitionResult)
        } else {
            guard let mostConfidentRecognition = inputNormalizationService.normalizeConfidence(from: results) else { return }
            inputNormalizationService.reset()
            recognitionResult = mostConfidentRecognition
            augmentedRealityViewController.updateDetectionViewfinder(to: recognitionResult)
            switch mostConfidentRecognition.recognition {
            case .car(let car):
                guard mostConfidentRecognition.confidence >= Constants.Recognition.Threshold.neededToPinARLabel else { break }
                classificationService.set(state: .paused)
                addSlidingCard(with: car)
                carsDataService.mark(car: car, asDiscovered: true)
                augmentedRealityViewController.addPin(to: car, completion: nil) { [unowned self] error in
                    // Debug information, invisible in production
                    self.customView.analyzeTimeLabel.text = error.rawValue
                    self.carCardViewController?.customView.animateAttachPinError()
                }
            case .otherCar, .notCar:
                break
            }
        }
        
        // Debug information, invisible in production
        customView.detectedModelLabel.text = recognitionResult.description
    }
    
    private func toggleViewsTo(cardMode: Bool, animated: Bool) {
        let viewsUpdateBlock = { [unowned self] in
            self.augmentedRealityViews(shouldHide: cardMode)
        }
        guard animated else {
            viewsUpdateBlock()
            return
        }
        UIView.animate(withDuration: 0.5) {
            viewsUpdateBlock()
        }
    }
    
    private func augmentedRealityViews(shouldHide: Bool) {
        let alpha: CGFloat = shouldHide ? 0 : 1
        augmentedRealityViewController.customView.detectionViewfinderView.alpha = alpha
        augmentedRealityViewController.customView.dimmView.alpha = alpha
    }
    
    private func addSlidingCard(with car: Car) {
        if carCardViewController != nil {
            removeSlidingCard(shouldAddAnimation: false)
        }
        carCardViewController = CarCardViewController(car: car)
        guard let carCardViewController = carCardViewController else { return }
        setup(carCardViewController: carCardViewController)
        self.toggleViewsTo(cardMode: true, animated: true)
        carCardViewController.animateIn()
        customView.mode = .withCard
    }
    
    private func setup(carCardViewController: CarCardViewController) {
        carCardViewController.eventTriggered = { [unowned self] event in
            switch event {
            case .didTapCarsList(let car):
                self.eventTriggered?(.didTriggerShowCarsList(car))
            case .didTapSearchGoogle(let car):
                self.eventTriggered?(.didTriggerGoogleSearch(car))
            case .didDismissViewByScanButtonTap, .didDismissView:
                self.toggleViewsTo(cardMode: false, animated: true)
                self.classificationService.set(state: .running)
                self.carCardViewController = nil
                self.customView.mode = .afterCardRemoval
            }
        }
        addChild(carCardViewController)
        view.addSubview(carCardViewController.view)
        carCardViewController.didMove(toParent: self)
        
        let height = CarCardViewController.Constants.cardHeight
        let width  = UIScreen.main.bounds.width
        carCardViewController.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.maxY + height, width: width, height: height)
    }
    
    @objc private func carsListButtonTapAction() {
        eventTriggered?(.didTriggerShowCarsList(nil))
    }
    
    @objc private func closeButtonTapAction() {
        UIView.animate(withDuration: 0.5) {
            self.augmentedRealityViews(shouldHide: true)
            self.customView.mode = .explore
        }
    }
    
    @objc private func scanButtonTapAction() {
        UIView.animate(withDuration: 0.5, animations: {
            self.augmentedRealityViews(shouldHide: false)
            self.customView.mode = .afterCardRemoval
        }) { completed in
            guard completed else { return }
            self.classificationService.set(state: .running)
        }
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

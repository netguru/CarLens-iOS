//
//  ApplicationFactory.swift
//  CarLens
//


/// Factory class that creates view controllers with proper dependencies
internal final class ApplicationFactory {
    
    private let applicationDependencies: ApplicationDependencies
    
    /// Initializes the factory with given dependencies
    ///
    /// - Parameter applicationDependencies: Dependencies used for creating controllers
    init(applicationDependencies: ApplicationDependencies) {
        self.applicationDependencies = applicationDependencies
    }
    
    /// Creates onboarding view controller
    ///
    /// - Returns: Created controller
    func onboardingViewController() -> OnboardingViewController {
        return OnboardingViewController(viewMaker: OnboardingView())
    }
    
    /// Creates controller with live camera AR view and bottom classification preview
    ///
    /// - Returns: Created controller
    func recognitionViewController() -> RecognitionViewController {
        return RecognitionViewController(
            augmentedRealityViewController: augmentedRealityViewController(),
            classificationService: CarClassificationService(carsDataService: applicationDependencies.carsDataService),
            carsDataService: applicationDependencies.carsDataService
        )
    }
    
    /// Creates controller with live augmented readlity camera preview
    ///
    /// - Returns: Created controller
    func augmentedRealityViewController() -> AugmentedRealityViewController {
        return AugmentedRealityViewController(viewMaker: AugmentedRealityView())
    }
    
    /// Creates controller with list of available cars to discover
    ///
    /// - Parameter discoveredCar: Optional which indicates wheter the view is initialized with scanned car or not
    /// - Returns: Created controller
    func carsListViewController(with discoveredCar: Car? = nil) -> CarsListViewController {
        return CarsListViewController(discoveredCar: discoveredCar, carsDataService: applicationDependencies.carsDataService)
    }

    /// Creates controller with camera access handling
    ///
    /// - Returns: Created controller
    func cameraAccessViewController() -> CameraAccessViewController {
        return CameraAccessViewController(viewMaker: CameraAccessView())
    }
}

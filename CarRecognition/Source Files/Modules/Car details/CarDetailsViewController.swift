//
//  CarDetailsViewController.swift
//  CarRecognition
//


internal final class CarDetailsViewController: TypedViewController<CarDetailsView> {
    
    private let networkService: NetworkService = DefaultNetworkService()
    
    private let recognizedCars: CarRecognizeResponse
    
    private let elementToAnalyze: RecognizedCar
    
    init(recognizedCars: CarRecognizeResponse) {
        self.recognizedCars = recognizedCars
        guard let firstCar = recognizedCars.cars.first else { fatalError("Not enough data provided") }
        self.elementToAnalyze = firstCar
        super.init(viewMaker: CarDetailsView())
    }
    
    /// SeeAlso: UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.modelLabel.text = "\(elementToAnalyze.car)\n(\(CRNumberFormatter.percentageFormatted(elementToAnalyze.confidence)))"
    }
}

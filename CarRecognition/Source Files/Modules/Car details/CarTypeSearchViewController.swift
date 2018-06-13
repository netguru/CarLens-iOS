//
//  CarTypeSearchViewController.swift
//  CarRecognition
//


internal final class CarTypeSearchViewController: TypedViewController<CarTypeSearchView> {
    
    private let networkService: NetworkService = DefaultNetworkService()
    
    private let recognizedCars: CarRecognizeResponse
    
    private let elementToAnalyze: RecognizedCar
    
    private var fetchedCars = [Car]()
    
    init(recognizedCars: CarRecognizeResponse) {
        self.recognizedCars = recognizedCars
        guard let firstCar = recognizedCars.cars.first else { fatalError("Not enough data provided") }
        self.elementToAnalyze = firstCar
        super.init(viewMaker: CarTypeSearchView())
    }
    
    /// SeeAlso: UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.modelLabel.text = "\(elementToAnalyze.car)\n(\(CRNumberFormatter.percentageFormatted(elementToAnalyze.confidence)))"
        customView.imageView.image = recognizedCars.analyzedImage
        
        fetchData()
    }
    
    private func updateView() {
        var textToSet = ""
        for car in fetchedCars {
            textToSet += car.description + "\n\n"
        }
        if !textToSet.isEmpty {
            customView.textView.text = textToSet
        } else {
            customView.textView.text = "No data found"
        }
    }
    
    private func fetchData() {
        let request = CarsSearchRequest(keyword: elementToAnalyze.car)
        networkService.perform(request: request) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.fetchedCars.removeAll()
                    self?.fetchedCars.append(contentsOf: response.cars)
                    self?.updateView()
                case .failure(let error):
                    self?.customView.textView.text = "Error occurred: \(error.description)"
                }
            }
        }
    }
}

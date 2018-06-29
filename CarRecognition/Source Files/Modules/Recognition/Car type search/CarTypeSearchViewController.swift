//
//  CarTypeSearchViewController.swift
//  CarRecognition
//


import UIKit

internal final class CarTypeSearchViewController: TypedViewController<CarTypeSearchView>, UITableViewDataSource, UITableViewDelegate {
    
    private let networkService: NetworkService = DefaultNetworkService()
    
    private let recognizedCars: CarClassifierResponse
    
    private let elementToAnalyze: RecognitionResult
    
    private var fetchedCars = [APICar]()
    
    init(recognizedCars: CarClassifierResponse) {
        self.recognizedCars = recognizedCars
        guard let firstCar = recognizedCars.cars.first else { fatalError("Not enough data provided") }
        self.elementToAnalyze = firstCar
        super.init(viewMaker: CarTypeSearchView())
    }
    
    /// SeeAlso: UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.tableView.dataSource = self
        customView.tableView.delegate = self
        customView.tableView.register(cell: UITableViewCell.self)
        
        customView.modelLabel.text = elementToAnalyze.description
        customView.imageView.image = recognizedCars.analyzedImage
        
        fetchData()
    }
    
    /// SeeAlso: UIViewController
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let selectedRow = customView.tableView.indexPathForSelectedRow {
            customView.tableView.deselectRow(at: selectedRow, animated: true)
        }
    }
    
    private func fetchData() {
        let request = CarsSearchRequest(keyword: elementToAnalyze.car.description)
        networkService.perform(request: request) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.fetchedCars.removeAll()
                    self?.fetchedCars.append(contentsOf: response.cars)
                    self?.customView.tableView.reloadData()
                case .failure(_):
                    break
                }
            }
        }
    }
    
    /// SeeAlso: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedCars.count
    }
    
    /// SeeAlso: UITableViewDataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: UITableViewCell = customView.tableView.dequeueReusableCell(for: indexPath) else {
            return UITableViewCell()
        }
        let model = fetchedCars[indexPath.row]
        cell.textLabel?.text = model.description
        return cell
    }
    
    /// SeeAlso: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = fetchedCars[indexPath.row]
        let detailsViewController = CarDetailsViewController(car: model)
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}

//
//  CarDetailsViewController.swift
//  CarRecognition
//


import UIKit

internal final class CarDetailsViewController: TypedViewController<UITableView>, UITableViewDataSource {
    
    private let car: APICar
    
    init(car: APICar) {
        self.car = car
        super.init(viewMaker: UITableView())
    }
    
    /// SeeAlso: UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.dataSource = self
        customView.register(cell: UITableViewCell.self)
    }
    
    /// SeeAlso: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return car.arrayDescription.count
    }
    
    /// SeeAlso: UITableViewDataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: UITableViewCell = customView.dequeueReusableCell(for: indexPath) else {
            return UITableViewCell()
        }
        let model = car.arrayDescription[indexPath.row]
        cell.textLabel?.text = model.description + ": " + (model.value ?? "")
        return cell
    }
}

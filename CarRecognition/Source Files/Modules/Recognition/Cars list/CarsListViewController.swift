//
//  CarsListViewController.swift
//  CarRecognition
//


import UIKit

internal final class CarsListViewController: TypedViewController<CarsListView>, UICollectionViewDataSource, UICollectionViewDelegate {
    
    private let carsDataService: CarsDataService
    
    private let discoveredCar: Car?
    
    /// Enum describing events that can be triggered by this controller
    ///
    /// - didTapDismiss: send when user want to dismiss the view
    /// - didTapBackButton: send when user taps on the back arrow on screen
    enum Event {
        case didTapDismiss
        case didTapBackButton
    }

    /// Callback with triggered event
    var eventTriggered: ((Event) -> ())?
    
    /// Initializes the view controller with given parameters
    ///
    /// - Parameter car: Car to be displayed by the view controller
    init(discoveredCar: Car? = nil, carsDataService: CarsDataService) {
        self.discoveredCar = discoveredCar
        self.carsDataService = carsDataService
        super.init(viewMaker: CarsListView(discoveredCar: discoveredCar, availableCars: carsDataService.getNumberOfCars()))
    }
    
    /// SeeAlso: UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.collectionView.dataSource = self
        customView.collectionView.delegate = self
        customView.collectionView.register(cell: CarListCollectionViewCell.self)
        customView.recognizeButton.addTarget(self, action: #selector(recognizeButtonTapAction), for: .touchUpInside)
        customView.topView.backButton.addTarget(self, action: #selector(backButtonTapAction), for: .touchUpInside)
    }
    
    /// SeeAlso: UIViewController
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateVisibleCells()
        invalidateDiscoveredProgressView()
    }
    
    @objc private func recognizeButtonTapAction() {
        eventTriggered?(.didTapDismiss)
    }
    
    @objc private func backButtonTapAction() {
        eventTriggered?(.didTapBackButton)
    }
    
    private func animateVisibleCells() {
        let cells = customView.collectionView.visibleCells.compactMap { $0 as? CarListCollectionViewCell }
        cells.forEach {
            if $0.isCurrentlyPrimary {
                $0.invalidateCharts(animated: true)
            } else {
                $0.clearCharts(animated: false)
            }
        }
    }

    private func invalidateDiscoveredProgressView() {
        let discoveredCars = carsDataService.getNumberOfDiscoveredCars()
        let availableCars = carsDataService.getNumberOfCars()
        customView.topView.progressView.setup(currentNumber: discoveredCars, maximumNumber: availableCars, invalidateChartInstantly: false)
        customView.topView.progressView.invalidateChart(animated: true)
    }

    /// SeeAlso: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return carsDataService.getNumberOfCars()
    }
    
    /// SeeAlso: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: CarListCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath) else {
            return UICollectionViewCell()
        }
        cell.setup(with: carsDataService.getAvailableCars()[indexPath.row])
        return cell
    }
    
    /// SeeAlso: UICollectionViewDelegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        animateVisibleCells()
    }
}

//
//  CarsListViewController.swift
//  CarLens
//


import UIKit

final class CarsListViewController: TypedViewController<CarsListView>,
                                    UICollectionViewDataSource, UICollectionViewDelegate {

    private var didCheckCarScroll = false

    private let carsDataService: CarsDataService

    private let discoveredCar: Car?

    private var cars = [Car]()

    /// Enum describing events that can be triggered by this controller
    ///
    /// - didTapDismiss: send when user want to dismiss the view
    /// - didTapBackButton: send when user taps on the back arrow on screen
    enum Event {
        case didTapDismiss
        case didTapBackButton
    }

    /// Callback with triggered event
    var eventTriggered: ((Event) -> Void)?

    /// Initializes the view controller with given parameters
    ///
    /// - Parameters:
    ///   - discoveredCar: Car to be displayed by the view controller
    ///   - carsDataService: Data service for retrieving informations about cars
    init(discoveredCar: Car? = nil, carsDataService: CarsDataService) {
        self.discoveredCar = discoveredCar
        self.carsDataService = carsDataService
        super.init(viewMaker: CarsListView(discoveredCar: discoveredCar,
                                           availableCars: carsDataService.getNumberOfCars()))
    }

    /// SeeAlso: UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        view.accessibilityIdentifier = "carsList/view/main"
        cars = carsDataService.getAvailableCars()
        customView.collectionView.dataSource = self
        customView.collectionView.delegate = self
        customView.collectionView.register(cell: CarListCollectionViewCell.self)
        customView.recognizeButton.addTarget(self, action: #selector(recognizeButtonTapAction), for: .touchUpInside)
        customView.topView.backButton.addTarget(self, action: #selector(backButtonTapAction), for: .touchUpInside)
    }

    /// SeeAlso: UIViewController
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupDiscoveredProgressView()
    }

    /// SeeAlso: UIViewController
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setChartsValuesForVisibleCells()
		customView.topView.progressView.setChart(animated: true, toZero: false)
    }

    /// SeeAlso: UIViewController
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard !didCheckCarScroll else { return }
        scrollToDiscoveredCarIfNeeded()
        didCheckCarScroll = true
    }

    @objc private func recognizeButtonTapAction() {
        eventTriggered?(discoveredCar == nil ? .didTapBackButton : .didTapDismiss)
    }

    @objc private func backButtonTapAction() {
        eventTriggered?(.didTapBackButton)
    }

    private func scrollToDiscoveredCarIfNeeded() {
        guard let discoveredCar = discoveredCar, let index = cars.index(of: discoveredCar) else { return }
        let indexPath = IndexPath(item: index, section: 0)
        customView.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
    }

    private func setChartsValuesForVisibleCells() {
        let cells = customView.collectionView.visibleCells.compactMap { $0 as? CarListCollectionViewCell }
        cells.forEach {
            $0.setChartsValues()
        }
    }

    private func setupDiscoveredProgressView() {
        let discoveredCars = carsDataService.getNumberOfDiscoveredCars()
        let availableCars = carsDataService.getNumberOfCars()
        customView.topView.progressView.setup(currentNumber: discoveredCars,
                                              maximumNumber: availableCars,
                                              setChartWithoutAnimation: false)
    }

    /// SeeAlso: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return carsDataService.getNumberOfCars()
    }

    /// SeeAlso: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: CarListCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath) else {
            return UICollectionViewCell()
        }
        cell.setup(with: cars[indexPath.row])
        return cell
    }

    /// SeeAlso: UICollectionViewDelegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        setChartsValuesForVisibleCells()
    }

    /// SeeAlso: UICollectionViewDelegate
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        setChartsValuesForVisibleCells()
    }
}

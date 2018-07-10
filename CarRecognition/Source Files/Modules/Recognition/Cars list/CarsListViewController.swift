//
//  CarsListViewController.swift
//  CarRecognition
//


import UIKit

internal final class CarsListViewController: TypedViewController<CarsListView>, UICollectionViewDataSource, UICollectionViewDelegate {
    
    /// Enum describing events that can be triggered by this controller
    ///
    /// - didTapDismiss: send when user want to dismiss the view
    /// - didTapBackButton: send when user taps on the back arrow on screen
    enum Event {
        case didTapDismiss
        case didTapBackButton
    }
    
    struct Constants {
        static let cellNumberOffset = 1
    }
    
    /// Callback with triggered event
    var eventTriggered: ((Event) -> ())?
    
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
        setProgressView()
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

    /// SeeAlso: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // TODO: Replace with the real number
        return 8
    }
    
    /// SeeAlso: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: CarListCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath) else {
            return UICollectionViewCell()
        }
        // TODO: Replace with getting the element from the model
        cell.setup(with: Car(label: "volkswagen passat")!)
        
        return cell
    }
    
    /// SeeAlso: UICollectionViewDelegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        animateVisibleCells()
        setProgressView()
    }
}

/// ProgressView animations
extension CarsListViewController {

    private func setProgressView() {
        guard let index = calculateIndexAfterDecelerating() else { return }
        animateProgressView(currentNumber: index + Constants.cellNumberOffset)
    }

    private func calculateIndexAfterDecelerating() -> Int? {
        var visibleRect = CGRect()
        visibleRect.origin = customView.collectionView.contentOffset
        visibleRect.size = customView.collectionView.bounds.size
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        let indexPath = customView.collectionView.indexPathForItem(at: visiblePoint)
        return indexPath?.row
    }

    private func animateProgressView(currentNumber: Int) {
        // TODO: Replace maximumNumber with real value
        customView.topView.progressView.setup(currentNumber: currentNumber, maximumNumber: 8, invalidateChartInstantly: false)
        customView.topView.progressView.invalidateChart(animated: true)
    }
}

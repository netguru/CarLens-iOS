//
//  CarsListView.swift
//  CarRecognition
//


import UIKit

internal final class CarsListView: View, ViewSetupable {

    /// Cars list collectiom view
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: CarListFlowLayout())
        view.backgroundColor = .clear
        view.showsHorizontalScrollIndicator = false
        view.accessibilityIdentifier = "carsList/collectionView/cars"
        return view.layoutable()
    }()
    
    /// Recognize button visible at the bottom
    lazy var recognizeButton: UIButton = {
        let view = UIButton(type: .system)
        view.setImage(#imageLiteral(resourceName: "button-scan-primary"), for: .normal)
        view.layer.shadowOpacity = 0.4
        view.layer.shadowColor = UIColor.crShadowOrange.withAlphaComponent(0.4).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 12)
        view.accessibilityIdentifier = "carsList/button/recognize"
        return view.layoutable()
    }()

    /// Custom navigation bar added at the top
    lazy var topView = CarListNavigationBar(currentNumber: 0, maximumNumber: availableCars).layoutable()
    
    private let discoveredCar: Car?
    
    private let availableCars: Int

    /// Initializes the view with given car
    ///
    /// - Parameters:
    ///   - discoveredCar: Car parameter that was displayed on the card when opening this view
    ///   - availableCars: Number of available cars
    init(discoveredCar: Car? = nil, availableCars: Int) {
        self.discoveredCar = discoveredCar
        self.availableCars = availableCars
        super.init()
    }

    /// - SeeAlso: ViewSetupable
    func setupViewHierarchy() {
        [topView, collectionView, recognizeButton].forEach(addSubview)
    }
    
    /// - SeeAlso: ViewSetupable
    func setupConstraints() {
        topView.constraintToSuperviewLayoutGuide(excludingAnchors: [.bottom])
        collectionView.constraintToSuperviewEdges(excludingAnchors: [.top, .bottom])
        recognizeButton.constraintToConstant(.init(width: 80, height: 80))
        NSLayoutConstraint.activate([
            topView.heightAnchor.constraint(equalToConstant: 70),
            collectionView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: UIDevice.screenSizeBiggerThan4Inches ? 20 : 0),
            collectionView.bottomAnchor.constraint(equalTo: recognizeButton.topAnchor, constant: -20),
            recognizeButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8),
            recognizeButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    /// - SeeAlso: ViewSetupable
    func setupProperties() {
        backgroundColor = .crBackgroundGray
        topView.backButton.isHidden = discoveredCar == nil
    }
}

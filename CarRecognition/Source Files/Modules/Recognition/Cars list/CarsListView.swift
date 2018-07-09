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
        return view.layoutable()
    }()
    
    /// Recognize button visible at the bottom
    lazy var recognizeButton: UIButton = {
        let view = UIButton(type: .system)
        view.setImage(#imageLiteral(resourceName: "button-scan-primary"), for: .normal)
        view.layer.shadowOpacity = 0.6
        view.layer.shadowColor = UIColor.crShadowOrange.withAlphaComponent(0.4).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 10)
        return view.layoutable()
    }()
    
    private lazy var topView = CarListNavigationBar().layoutable()
    
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
            collectionView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 20),
            collectionView.bottomAnchor.constraint(equalTo: recognizeButton.topAnchor, constant: -20),
            recognizeButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8),
            recognizeButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    /// - SeeAlso: ViewSetupable
    func setupProperties() {
        backgroundColor = .crBackgroundGray
    }
}

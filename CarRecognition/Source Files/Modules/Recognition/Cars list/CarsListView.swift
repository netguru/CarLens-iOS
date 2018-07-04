//
//  CarsListView.swift
//  CarRecognition
//


import UIKit

internal final class CarsListView: View, ViewSetupable {
    
    /// Recognize button visible at the bottom
    lazy var recognizeButton: UIButton = {
        let view = UIButton(type: .system)
        view.setImage(#imageLiteral(resourceName: "button-scan-primary"), for: .normal)
        return view.layoutable()
    }()
    
    private lazy var testStackView: UIStackView = .make(
        axis: .vertical,
        with: [
            FullOvalProgressView(currentNumber: 3, maximumNumber: 9, invalidateChartInstantly: false),
            PartOvalProgressView(state: .accelerate(9), invalidateChartInstantly: false),
            PartOvalProgressView(state: .topSpeed(94), invalidateChartInstantly: false),
            HorizontalProgressChartView(state: .power(115), invalidateChartInstantly: false),
            HorizontalProgressChartView(state: .engine(1588), invalidateChartInstantly: false),
            HorizontalStarsView()
        ],
        spacing: 20
    )
    
    /// - SeeAlso: ViewSetupable
    func setupViewHierarchy() {
        addSubview(recognizeButton)
        addSubview(testStackView)
    }
    
    /// - SeeAlso: ViewSetupable
    func setupConstraints() {
        testStackView.constraintCenterToSuperview()
        recognizeButton.constraintToConstant(.init(width: 80, height: 80))
        NSLayoutConstraint.activate([
            recognizeButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -27),
            recognizeButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    /// - SeeAlso: ViewSetupable
    func setupProperties() {
        backgroundColor = .crBackgroundGray
    }
}

//
//  CarListCardView.swift
//  CarRecognition
//


import UIKit

internal final class CarListCardView: View, ViewSetupable {
    
    private lazy var topSpeedProgressView = PartOvalProgressView(state: .topSpeed(0), invalidateChartInstantly: false)
    
    private lazy var accelerationProgressView = PartOvalProgressView(state: .accelerate(0), invalidateChartInstantly: false)
    
    private lazy var engineProgressView = HorizontalProgressChartView(state: .engine(0), invalidateChartInstantly: false)
    
    private lazy var powerProgressView = HorizontalProgressChartView(state: .power(0), invalidateChartInstantly: false)
    
    private lazy var starsProgressView: HorizontalStarsView = {
        let view = HorizontalStarsView(starCount: 3, invalidateChartInstantly: false)
        view.backgroundColor = .white
        return view.layoutable()
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let view = UILabel()
        view.textColor = .crFontLightGray
        view.font = .gliscorGothicFont(ofSize: 12)
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var makeImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view.layoutable()
    }()
    
    private lazy var separatorLine: UIView = .separator(axis: .vertical, thickness: 1, color: .crBackgroundLightGray)
    
    private lazy var performanceStackView: UIStackView = .make(
        axis: .horizontal,
        with: [topSpeedProgressView, accelerationProgressView],
        spacing: 10,
        distribution: .fillEqually
    )
    
    private lazy var mechanicalStackView: UIStackView = .make(
        axis: .horizontal,
        with: [engineProgressView, powerProgressView],
        spacing: 30,
        distribution: .fillEqually
    )
    
    private lazy var containerStackView: UIStackView = .make(
        axis: .vertical,
        with: [performanceStackView, separatorLine, descriptionLabel, mechanicalStackView],
        spacing: 0,
        distribution: .equalSpacing
    )
    
    /// Initializes the view with given car
    ///
    /// - Parameter car: Car to be used for updating the view
    init(car: Car? = nil) {
        super.init()
        guard let car = car else { return }
        setup(with: car)
    }
    
    /// Setups the view with given car. Use only inside reusable views.
    ///
    /// - Parameter car: Car to be used for updating the view
    func setup(with car: Car) {
        // TODO: Remove when local car database will be ready
        let carMakeImage = #imageLiteral(resourceName: "VolkswagenPassat")
        let carDescription = "The Volkswagen Tiguan is a compact crossover vehicle (CUV). Introduced in 2007, it uses the PQ35 platform of the Volkswagen Golf."
        let carTopSpeed = 94
        let carAccelerate: TimeInterval = 9
        let carPower = 115
        let carEngine = 1588
        let carStars = 3
        
        makeImageView.image = carMakeImage
        topSpeedProgressView.setup(state: .topSpeed(carTopSpeed), invalidateChartInstantly: false)
        accelerationProgressView.setup(state: .accelerate(carAccelerate), invalidateChartInstantly: false)
        engineProgressView.setup(state: .engine(carEngine), invalidateChartInstantly: false)
        powerProgressView.setup(state: .power(carPower), invalidateChartInstantly: false)
        starsProgressView.setup(starCount: carStars, invalidateChartInstantly: false)
        descriptionLabel.attributedText = NSAttributedStringFactory.trackingApplied(carDescription, font: descriptionLabel.font, tracking: 0.6)
    }
    
    /// Invalidates the charts visible on the view
    ///
    /// - Parameter animated: Indicating if invalidation should be animated
    func invalidateCharts(animated: Bool) {
        topSpeedProgressView.invalidateChart(animated: animated)
        accelerationProgressView.invalidateChart(animated: animated)
        engineProgressView.invalidateChart(animated: animated)
        powerProgressView.invalidateChart(animated: animated)
        starsProgressView.invalidateChart(animated: animated)
    }
    
    /// Clear the progress shown on charts
    ///
    /// - Parameter animated: Indicating if progress change should be animated
    func clearCharts(animated: Bool) {
        topSpeedProgressView.clearChart(animated: animated)
        accelerationProgressView.clearChart(animated: animated)
        engineProgressView.clearChart(animated: animated)
        powerProgressView.clearChart(animated: animated)
        starsProgressView.clearChart(animated: animated)
    }
    
    /// - SeeAlso: ViewSetupable
    func setupViewHierarchy() {
        [containerStackView, makeImageView].forEach(addSubview)
        separatorLine.addSubview(starsProgressView)
    }
    
    /// - SeeAlso: ViewSetupable
    func setupConstraints() {
        containerStackView.constraintToSuperviewEdges(withInsets: .init(top: 30, left: 30, bottom: 30, right: 30))
        starsProgressView.constraintCenterToSuperview()
        topSpeedProgressView.constraintToConstant(.init(width: 85, height: 85))
        accelerationProgressView.constraintToConstant(.init(width: 85, height: 85))
        makeImageView.constraintToConstant(.init(width: 37, height: 37))
        NSLayoutConstraint.activate([
            makeImageView.topAnchor.constraint(equalTo: topAnchor, constant: -19),
            makeImageView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}

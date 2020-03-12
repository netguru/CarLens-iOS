//
//  CarListCardView.swift
//  CarLens
//


import UIKit

final class CarListCardView: View, ViewSetupable {

    private lazy var topSpeedProgressView = PartOvalProgressView(state: .topSpeed(0))

    private lazy var accelerationProgressView = PartOvalProgressView(state: .accelerate(0))

    private lazy var engineProgressView = HorizontalProgressChartView(state: .engine(0))

    private lazy var powerProgressView = HorizontalProgressChartView(state: .power(0))

    private lazy var starsProgressView: HorizontalStarsView = {
        let view = HorizontalStarsView(starCount: 3)
        view.backgroundColor = .white
        return view.layoutable()
    }()

	private lazy var progressableViews: [ViewProgressable] = [
		topSpeedProgressView,
		accelerationProgressView,
		engineProgressView,
		powerProgressView,
		starsProgressView
	]

    private lazy var descriptionLabel: UILabel = {
        let view = UILabel()
        view.textColor = .crFontLightGray
        view.numberOfLines = 0
        view.isHidden = !UIDevice.screenSizeBiggerThan4Inches
        return view
    }()

    private lazy var makeImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view.layoutable()
    }()

    private lazy var separatorLine: UIView = .separator(axis: .vertical, thickness: 1, color: .crBackgroundLightGray)

    private lazy var performanceStackView: UIStackView = {
        let view = UIStackView.make(
            axis: .horizontal,
            with: [topSpeedProgressView, accelerationProgressView],
            spacing: UIDevice.screenSizeBiggerThan4Inches ? 40 : 25,
            distribution: .fillEqually
        )
        view.layoutMargins = .init(top: 0, left: 15, bottom: 0, right: 15)
        view.isLayoutMarginsRelativeArrangement = true
        return view
    }()

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
        makeImageView.image = car.isDiscovered ? car.image.logoUnlocked : car.image.logoLocked
        topSpeedProgressView.setup(state: .topSpeed(car.speed),
                                   setChartWithoutAnimation: false,
                                   isLocked: !car.isDiscovered)
        accelerationProgressView.setup(state: .accelerate(car.acceleration),
                                       setChartWithoutAnimation: false,
                                       isLocked: !car.isDiscovered)
        engineProgressView.setup(state: .engine(car.engine),
                                 setChartWithoutAnimation: false,
                                 isLocked: !car.isDiscovered)
        powerProgressView.setup(state: .power(car.power), setChartWithoutAnimation: false, isLocked: !car.isDiscovered)
        starsProgressView.setup(starCount: car.stars, setChartWithoutAnimation: false, isLocked: !car.isDiscovered)
        descriptionLabel.textColor = car.isDiscovered ? .crFontLightGray : .crBackgroundLightGray
        let descriptionFont = car.isDiscovered ? UIFont.systemFont(ofSize: 12) : .blokkNeueFont(ofSize: 12)
        descriptionLabel.attributedText = NSAttributedStringFactory.trackingApplied(car.description,
                                                                                    font: descriptionFont,
                                                                                    tracking: .condensed)
    }

	/// Sets all charts of the view
    ///
    /// - Parameters:
    ///   - animated: Indicating if the change should be animated
    ///   - toZero: Indicating if charts should be cleared
	func setCharts(animated: Bool, toZero: Bool) {
		progressableViews.forEach { $0.setChart(animated: animated, toZero: toZero) }
    }

    /// - SeeAlso: ViewSetupable
    func setupViewHierarchy() {
        [containerStackView, makeImageView].forEach(addSubview)
        separatorLine.addSubview(starsProgressView)
    }

    /// - SeeAlso: ViewSetupable
    func setupConstraints() {
        let inset: CGFloat = UIDevice.screenSizeBiggerThan4Inches ? 20 : 10
        containerStackView.constraintToSuperviewEdges(withInsets: .init(top: inset, left: inset,
                                                                        bottom: inset, right: inset))
        starsProgressView.constraintCenterToSuperview()
        makeImageView.constraintToConstant(.init(width: 37, height: 37))
        NSLayoutConstraint.activate([
            makeImageView.topAnchor.constraint(equalTo: topAnchor, constant: -19),
            makeImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            topSpeedProgressView.heightAnchor.constraint(equalTo: topSpeedProgressView.widthAnchor),
            accelerationProgressView.heightAnchor.constraint(equalTo: accelerationProgressView.widthAnchor)
        ])
    }
}

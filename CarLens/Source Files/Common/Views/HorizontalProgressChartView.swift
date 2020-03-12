//
//  HorizontalProgressChartView.swift
//  CarLens
//


import UIKit
import Lottie

final class HorizontalProgressChartView: View, ViewSetupable {

    /// States available to display by this view
    enum State {
        case power(Int)
        case engine(Int)
    }

    private var state: State

    private var isLocked: Bool

    private let chartConfig = CarSpecificationChartConfiguration()

    private lazy var animationView = LOTAnimationView(name: "horizontal-progress-chart").layoutable()

    private lazy var valueLabel: UILabel = {
        let view = UILabel()
        view.font = .gliscorGothicFont(ofSize: 20)
        view.textColor = .crFontDark
        view.numberOfLines = 1
        view.textAlignment = .left
        return view.layoutable()
    }()

    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = .gliscorGothicFont(ofSize: 12)
        view.textColor = .crFontGray
        view.numberOfLines = 1
        view.textAlignment = .left
        return view.layoutable()
    }()

    /// Initializes the view with given state
    ///
    /// - Parameters:
    ///   - state: State to be shown by the view
    ///   - setChartWithoutAnimation: Chart will be updated instantly without animation if this value indicates true.
    ///                               When passing true, remember to use method `setChart(animated:toZero:)` also
    ///   - isLocked: Indicating if the info should be locked
    init(state: State, setChartWithoutAnimation: Bool = false, isLocked: Bool = false) {
        self.state = state
        self.isLocked = isLocked
        super.init()
        setup(state: state, setChartWithoutAnimation: setChartWithoutAnimation, isLocked: isLocked)
    }

    /// Setups the view with given state. Use only inside reusable views.
    ///
    /// - Parameters:
    ///   - state: State to be shown by the view
    ///   - setChartWithoutAnimation: Chart will be updated instantly without animation if this value indicates true.
    ///                               When passing true, remember to use method `setChart(animated:toZero:)` also
    ///   - isLocked: Indicating if the info should be locked
    func setup(state: State, setChartWithoutAnimation: Bool, isLocked: Bool = false) {
        animationView.set(progress: 0, animated: false)
        self.state = state
        self.isLocked = isLocked
        switch state {
        case .power(let power):
            let valueText = String(power) + "\(Localizable.CarCard.hp)"
            valueLabel.attributedText = NSAttributedStringFactory
                .trackingApplied(valueText,
                                 font: valueLabel.font,
                                 tracking: .condensed)
            titleLabel.attributedText = NSAttributedStringFactory
                .trackingApplied(Localizable.CarCard.power.uppercased(),
                                 font: titleLabel.font,
                                 tracking: .condensed)
        case .engine(let engine):
            let valueText = "\(engine)\(Localizable.CarCard.cc)"
            valueLabel.attributedText = NSAttributedStringFactory
                .trackingApplied(valueText,
                                 font: valueLabel.font,
                                 tracking: .condensed)
            titleLabel.attributedText = NSAttributedStringFactory
                .trackingApplied(Localizable.CarCard.engine.uppercased(),
                                 font: titleLabel.font,
                                 tracking: .condensed)
        }
        if setChartWithoutAnimation {
			setChart(animated: false, toZero: false)
        }
        valueLabel.textColor = isLocked ? .crFontGrayLocked : .crFontDark
        if isLocked {
            valueLabel.text = "?"
        }
    }

    /// - SeeAlso: ViewSetupable
    func setupViewHierarchy() {
        [animationView, valueLabel, titleLabel].forEach(addSubview)
    }

    /// - SeeAlso: ViewSetupable
    func setupConstraints() {
        titleLabel.constraintToSuperviewEdges(excludingAnchors: [.bottom])
        valueLabel.constraintToSuperviewEdges(excludingAnchors: [.top, .bottom])
        animationView.constraintToSuperviewEdges(excludingAnchors: [.top])
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: animationView.topAnchor, constant: 3),
            valueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: -3)
        ])
    }
}

extension HorizontalProgressChartView: ViewProgressable {

    /// - SeeAlso: ViewProgressable
	func setChart(animated: Bool, toZero: Bool) {
        var progress: Double
        switch state {
        case .power(let power):
            progress = Double(power) / Double(chartConfig.referenceHorsePower)
        case .engine(let engine):
            progress = Double(engine) / Double(chartConfig.referenceEngineVolume)
        }
        if isLocked || toZero {
            progress = 0
        }
        animationView.set(progress: CGFloat(progress), animated: animated)
    }
}

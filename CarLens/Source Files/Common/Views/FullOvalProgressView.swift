//
//  FullOvalProgressView.swift
//  CarLens
//


import UIKit
import Lottie

final class FullOvalProgressView: View, ViewSetupable {

    /// Struct with dimensions
    enum Dimensions {
        static let startAngle: CGFloat = 3/2 * .pi
        static let endAngle: CGFloat = 7/2 * .pi
        static let lineWidth: CGFloat = 4
    }

    private let fullOvalLayerView = OvalProgressLayerView(
        startAngle: Dimensions.startAngle,
        endAngle: Dimensions.endAngle,
        lineWidth: Dimensions.lineWidth,
        progressStrokeColor: .crShadowOrange
    ).layoutable()

    private lazy var valueLabel: UILabel = {
        let view = UILabel()
        view.font = .gliscorGothicFont(ofSize: 20)
        view.textColor = .crFontDark
        view.numberOfLines = 1
        view.textAlignment = .center
        return view.layoutable()
    }()

    private var currentNumber: Int

    private var maximumNumber: Int

    /// Initializes the view with given parameters
    ///
    /// - Parameters:
    ///   - currentNumber: Currently achieved number
    ///   - maximumNumber: Maximum available number
    ///   - setChartWithoutAnimation: Chart will be updated instantly without animation if this value indicates true.
    ///                               When passing true, remember to use method `setChart(animated:toZero:)` also
    init(currentNumber: Int, maximumNumber: Int, setChartWithoutAnimation: Bool = false) {
        self.currentNumber = currentNumber
        self.maximumNumber = maximumNumber
        super.init()
        setup(currentNumber: currentNumber,
              maximumNumber: maximumNumber,
              setChartWithoutAnimation: setChartWithoutAnimation)
        accessibilityIdentifier = "carsList/view/ovalProgress"
    }

    /// Setups the view with given parameters. Use only inside reusable views.
    ///
    /// - Parameters:
    ///   - currentNumber: Currently achieved number
    ///   - maximumNumber: Maximum available number
    ///   - setChartWithoutAnimation: Chart will be updated instantly without animation if this value indicates true.
    ///                               When passing true, remember to use method `setChart(animated:toZero:)` also
    func setup(currentNumber: Int, maximumNumber: Int, setChartWithoutAnimation: Bool) {
        fullOvalLayerView.set(progress: 0, animated: false)
        self.currentNumber = currentNumber
        self.maximumNumber = maximumNumber

        let valueText = "\(currentNumber)/\(maximumNumber)"
        valueLabel.attributedText = NSAttributedStringFactory.trackingApplied(valueText,
                                                                              font: valueLabel.font,
                                                                              tracking: .condensed)
        if setChartWithoutAnimation {
            setChart(animated: false, toZero: false)
        }
    }

    /// - SeeAlso: ViewSetupable
    func setupViewHierarchy() {
        [fullOvalLayerView, valueLabel].forEach(addSubview)
    }

    /// - SeeAlso: ViewSetupable
    func setupConstraints() {
        fullOvalLayerView.constraintToSuperviewEdges()
        valueLabel.constraintToSuperviewEdges(excludingAnchors: [.top, .bottom],
                                              withInsets: .init(top: 0, left: 8, bottom: 0, right: 8))
        NSLayoutConstraint.activate([
            valueLabel.centerYAnchor.constraint(equalTo: fullOvalLayerView.centerYAnchor)
        ])
    }
}

extension FullOvalProgressView: ViewProgressable {

    /// - SeeAlso: ViewProgressable
	func setChart(animated: Bool, toZero: Bool) {
		let progress = toZero ? 0 : Double(currentNumber) / Double(maximumNumber)
		fullOvalLayerView.set(progress: progress, animated: animated)
    }
}

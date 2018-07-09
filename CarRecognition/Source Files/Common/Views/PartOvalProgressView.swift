//
//  PartOvalProgressView.swift
//  CarRecognition
//


import UIKit
import Lottie

internal final class PartOvalProgressView: View, ViewSetupable {

    /// States available to display by this view
    enum State {
        case accelerate(TimeInterval)
        case topSpeed(Int)
    }
    
    /// Struct with dimensions
    struct Dimensions {
        static let startAngle: CGFloat = 0.8 * .pi
        static let endAngle: CGFloat = 0.2 * .pi
        static let valueFontSize: CGFloat = 20
        static let titleFontSize: CGFloat = 14
    }
    
    private var state: State
    
    private let chartConfig = CarSpecificationChartConfiguration()
    
    private let layerView: OvalProgressLayerView = {
        let view = OvalProgressLayerView(startAngle: Dimensions.startAngle, endAngle: Dimensions.endAngle, progressStrokeColor: UIColor.crShadowOrange)
        return view.layoutable()
    }()
    
    private lazy var valueLabel: UILabel = {
        let view = UILabel()
        view.font = .gliscorGothicFont(ofSize: Dimensions.valueFontSize)
        view.textColor = .crFontDark
        view.numberOfLines = 1
        view.textAlignment = .center
        return view.layoutable()
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = .gliscorGothicFont(ofSize: Dimensions.titleFontSize)
        view.textColor = .crFontGray
        view.numberOfLines = 1
        view.textAlignment = .center
        return view.layoutable()
    }()
    
    /// Initializes the view with given state
    ///
    /// - Parameters:
    ///   - state: State to be shown by the view
    ///   - invalidateChartInstantly: Chart will be updated instantly without animation if this value indicates false.
    ///                               When passing false, remember to use method `invalidatChart(animated:)` also
    init(state: State, invalidateChartInstantly: Bool) {
        self.state = state
        super.init()
        setup(state: state, invalidateChartInstantly: invalidateChartInstantly)
    }
    
    /// Setups the view with given state. Use only inside reusable views.
    ///
    /// - Parameters:
    ///   - state: State to be shown by the view
    ///   - invalidateChartInstantly: Chart will be updated instantly without animation if this value indicates false.
    ///                               When passing false, remember to use method `invalidatChart(animated:)` also
    func setup(state: State, invalidateChartInstantly: Bool) {
        layerView.setProgress(progress: 0, animated: false)
        self.state = state
        switch state {
        case .accelerate(let accelerate):
            let formatter = DateComponentsFormatter()
            formatter.unitsStyle = .short
            formatter.allowedUnits = .second
            
            let valueText = (formatter.string(from: accelerate) ?? "") + "."
            valueLabel.attributedText = NSAttributedStringFactory.trackingApplied(valueText, font: valueLabel.font, tracking: 0.6)
            titleLabel.text = Localizable.CarCard.accelerate0to60mph.uppercased()
        case .topSpeed(let topSpeed):
            let valueText = "\(topSpeed) \(Localizable.CarCard.mph)"
            valueLabel.attributedText = NSAttributedStringFactory.trackingApplied(valueText, font: valueLabel.font, tracking: 0.6)
            titleLabel.text = Localizable.CarCard.topSpeed.uppercased()
        }
        if invalidateChartInstantly {
            invalidateChart(animated: false)
        }
    }
    
    /// Invalidates the progress shown on the chart
    ///
    /// - Parameter animated: Indicating if invalidation should be animated
    func invalidateChart(animated: Bool) {
        let progress: Double
        switch state {
        case .accelerate(let accelerate):
            progress = accelerate / chartConfig.referenceAccelerate
        case .topSpeed(let topSpeed):
            progress = Double(topSpeed) / Double(chartConfig.referenceSpeed)
        }
        layerView.setProgress(progress: progress, animated: animated)
    }
    
    /// Clear the progress shown on the chart
    ///
    /// - Parameter animated: Indicating if progress change should be animated
    func clearChart(animated: Bool) {
        layerView.setProgress(progress: 0, animated: animated)
    }
    
    /// - SeeAlso: ViewSetupable
    func setupViewHierarchy() {
        [layerView, valueLabel, titleLabel].forEach(addSubview)
    }
    
    /// - SeeAlso: ViewSetupable
    func setupConstraints() {
        layerView.constraintToSuperviewEdges()
        valueLabel.constraintToSuperviewEdges(excludingAnchors: [.top, .bottom], withInsets: .init(top: 0, left: 8, bottom: 0, right: 8))
        titleLabel.constraintToSuperviewEdges(excludingAnchors: [.top], withInsets: .init(top: 0, left: 8, bottom: 0, right: 8))
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: layerView.bottomAnchor, constant: -12),
            valueLabel.centerYAnchor.constraint(equalTo: layerView.centerYAnchor)
        ])
    }
}

//
//  PartOvalProgressView.swift
//  CarLens
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
    
    private var isLocked: Bool
    
    private let chartConfig = CarSpecificationChartConfiguration()

    private let ovalLayerView = OvalProgressLayerView(
        startAngle: Dimensions.startAngle,
        endAngle: Dimensions.endAngle,
        progressStrokeColor: .crShadowOrange,
        trackStrokeColor: .crBackgroundLightGray
    ).layoutable()

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
    ///   - isLocked: Indicating if the info should be locked
    init(state: State, invalidateChartInstantly: Bool, isLocked: Bool = false) {
        self.state = state
        self.isLocked = isLocked
        super.init()
        setup(state: state, invalidateChartInstantly: invalidateChartInstantly, isLocked: isLocked)
    }
    
    /// Setups the view with given state. Use only inside reusable views.
    ///
    /// - Parameters:
    ///   - state: State to be shown by the view
    ///   - invalidateChartInstantly: Chart will be updated instantly without animation if this value indicates false.
    ///                               When passing false, remember to use method `invalidatChart(animated:)` also
    ///   - isLocked: Indicating if the info should be locked
    func setup(state: State, invalidateChartInstantly: Bool, isLocked: Bool = false) {
        ovalLayerView.set(progress: 0, animated: false)
        self.state = state
        self.isLocked = isLocked
        let speedText: String
        let topSpeedText: String
        switch SystemMetrics.shared.speedType {
        case .mph:
            speedText = Localizable.CarCard.accelerate0to60mph.uppercased()
            topSpeedText = Localizable.CarCard.mph
        case .kph:
            speedText = Localizable.CarCard.accelerate0to100kph.uppercased()
            topSpeedText = Localizable.CarCard.kph
        }
        
        switch state {
        case .accelerate(let accelerate):
            let formatter = DateComponentsFormatter()
            formatter.unitsStyle = .short
            formatter.allowedUnits = .second
            
            let valueText = formatter.string(from: accelerate) ?? ""
            valueLabel.attributedText = NSAttributedStringFactory.trackingApplied(valueText, font: valueLabel.font, tracking: .condensed)
            titleLabel.attributedText = NSAttributedStringFactory.trackingApplied(speedText, font: titleLabel.font, tracking: .condensed)
        case .topSpeed(let topSpeed):
            let valueText = "\(topSpeed) \(topSpeedText)"
            valueLabel.attributedText = NSAttributedStringFactory.trackingApplied(valueText, font: valueLabel.font, tracking: .condensed)
            titleLabel.attributedText = NSAttributedStringFactory.trackingApplied(Localizable.CarCard.topSpeed.uppercased(), font: titleLabel.font, tracking: .condensed)
        }
        if invalidateChartInstantly {
            invalidateChart(animated: false)
        }
        valueLabel.textColor = isLocked ? .crFontGrayLocked : .crFontDark
        if isLocked {
            valueLabel.text = "?"
        }
    }
    
    /// Clear the progress shown on the chart
    ///
    /// - Parameter animated: Indicating if progress change should be animated
    func clearChart(animated: Bool) {
        ovalLayerView.set(progress: 0, animated: animated)
    }
    
    /// - SeeAlso: ViewSetupable
    func setupViewHierarchy() {
        [ovalLayerView, valueLabel, titleLabel].forEach(addSubview)
    }
    
    /// - SeeAlso: ViewSetupable
    func setupConstraints() {
        ovalLayerView.constraintToSuperviewEdges()
        valueLabel.constraintToSuperviewEdges(excludingAnchors: [.top, .bottom], withInsets: .init(top: 0, left: 8, bottom: 0, right: 8))
        titleLabel.constraintToSuperviewEdges(excludingAnchors: [.top], withInsets: .init(top: 0, left: 8, bottom: 0, right: 8))
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: ovalLayerView.bottomAnchor, constant: -12),
            valueLabel.centerYAnchor.constraint(equalTo: ovalLayerView.centerYAnchor)
        ])
    }
}

extension PartOvalProgressView: ViewProgressable {
    
    /// - SeeAlso: ViewProgressable
    func invalidateChart(animated: Bool) {
        var progress: Double
        switch state {
        case .accelerate(let accelerate):
            progress = 1 - (accelerate / (chartConfig.referenceMaxAccelerate - chartConfig.referenceMinAccelerate))
        case .topSpeed(let topSpeed):
            progress = Double(topSpeed) / Double(chartConfig.referenceSpeed)
        }
        if isLocked {
            progress = 0
        }
        ovalLayerView.set(progress: progress, animated: animated)
    }
}

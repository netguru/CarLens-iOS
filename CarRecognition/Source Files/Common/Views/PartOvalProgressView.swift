//
//  PartOvalProgressView.swift
//  CarRecognition
//


import UIKit
import Lottie

internal final class PartOvalProgressView: View, ViewSetupable {

    private struct Constants {
        static let animationKey = "strokeEnd"
    }
    
    /// States available to display by this view
    enum State {
        case accelerate(TimeInterval)
        case topSpeed(Int)
    }
    
    private let state: State
    
    private let progressLayer = CAShapeLayer()
    
    private let chartConfig = CarSpecificationChartConfiguration()
    
    private let layerView = UIView().layoutable()
    
    private lazy var valueLabel: UILabel = {
        let view = UILabel()
        view.font = .gliscorGothicFont(ofSize: 20)
        view.textColor = .crFontDark
        view.numberOfLines = 1
        view.textAlignment = .center
        return view.layoutable()
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = .gliscorGothicFont(ofSize: 14)
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
    
    /// - SeeAlso: UIView.layoutSubviews()
    override func layoutSubviews() {
        super.layoutSubviews()
        drawCustomLayer()
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
        startAnimationWithProgress(progress, animated: animated)
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

extension PartOvalProgressView {
    private func drawCustomLayer() {
        let circularPath = UIBezierPath(arcCenter: layerView.center,
                                        radius: 42,
                                        startAngle: 0.8 * .pi,
                                        endAngle: 0.2 * .pi,
                                        clockwise: true)
        let trackLayer = CAShapeLayer()
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.crBackgroundGray.cgColor
        trackLayer.lineWidth = 6
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = kCALineCapRound
        layer.addSublayer(trackLayer)

        progressLayer.path = circularPath.cgPath
        progressLayer.strokeColor = UIColor.crShadowOrange.cgColor
        progressLayer.lineWidth = 6
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = kCALineCapRound
        progressLayer.strokeEnd = 0
        layer.addSublayer(progressLayer)

        /// TEMP Set temp values - should be removed when real data will be presented
        startAnimationWithProgress(0.5, animated: true)
    }
    
    private func startAnimationWithProgress(_ progress: Double, animated: Bool) {
        guard animated else {
            progressLayer.strokeEnd = CGFloat(progress)
            return
        }
        let basicAnimation = CABasicAnimation(keyPath: Constants.animationKey)
        basicAnimation.toValue = progress
        basicAnimation.duration = 1.5
        basicAnimation.fillMode = kCAFillModeForwards
        basicAnimation.isRemovedOnCompletion = false

        progressLayer.add(basicAnimation, forKey: "PartOvalProgressView.ProgressLayer.animation")
    }
}

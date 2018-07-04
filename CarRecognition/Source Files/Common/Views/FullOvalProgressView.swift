//
//  FullOvalProgressView.swift
//  CarRecognition
//


import UIKit
import Lottie

internal final class FullOvalProgressView: View, ViewSetupable {
    
    /// States avilable to display by this view
    enum State {
        case accelerate(TimeInterval)
        case topSpeed(Int)
    }
    
    private let state: State
    
    private let chartConfig = CarSpecificationChartConfiguration()
    
    private lazy var animationView = LOTAnimationView(name: "full_oval_progress").layoutable()
    
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
    ///   - state: State to bet shown by the biew
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
            
            valueLabel.text = (formatter.string(from: accelerate) ?? "") + "."
            titleLabel.text = Localizable.CarCard.accelerate0to60mph.uppercased()
        case .topSpeed(let topSpeed):
            valueLabel.text = "\(topSpeed) mph"
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
        if animated {
            animationView.play(toProgress: CGFloat(progress))
        } else {
            animationView.animationProgress = CGFloat(progress)
        }
    }
    
    /// - SeeAlso: ViewSetupable
    func setupViewHierarchy() {
        [animationView, valueLabel, titleLabel].forEach(addSubview)
    }
    
    /// - SeeAlso: ViewSetupable
    func setupConstraints() {
        animationView.constraintToSuperviewEdges(excludingAnchors: [.bottom], withInsets: .init(top: 0, left: 0, bottom: 0, right: 8))
        valueLabel.constraintToSuperviewEdges(excludingAnchors: [.top, .bottom], withInsets: .init(top: 0, left: 8, bottom: 0, right: 8))
        titleLabel.constraintToSuperviewEdges(excludingAnchors: [.top], withInsets: .init(top: 0, left: 8, bottom: 4, right: 8))
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: animationView.bottomAnchor, constant: 4),
            valueLabel.centerYAnchor.constraint(equalTo: animationView.centerYAnchor)
        ])
    }
    
    /// - SeeAlso: ViewSetupable
    func setupProperties() {
        animationView.clipsToBounds = false
        animationView.loopAnimation = true
        animationView.play(toProgress: 1.0, withCompletion: nil)
        
        valueLabel.text = "94 mph"
        titleLabel.text = "TOP SPEED"
        backgroundColor = .gray
    }
}

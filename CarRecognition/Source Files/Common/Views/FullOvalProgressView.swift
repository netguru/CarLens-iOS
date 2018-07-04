//
//  FullOvalProgressView.swift
//  CarRecognition
//


import UIKit
import Lottie

internal final class FullOvalProgressView: View, ViewSetupable {
    
    private lazy var animationView = LOTAnimationView(name: "full_oval_progress").layoutable()
    
    private lazy var valueLabel: UILabel = {
        let view = UILabel()
        view.font = .gliscorGothicFont(ofSize: 20)
        view.textColor = .crFontDark
        view.numberOfLines = 1
        view.textAlignment = .center
        return view.layoutable()
    }()
    
    private let currentNumber: Int
    
    private let maximumNumber: Int
    
    /// Initializes the view with given parameters
    ///
    /// - Parameters:
    ///   - currentNumber: Currently achieved number
    ///   - maximumNumber: Maximum abialable number
    ///   - invalidateChartInstantly: Chart will be updated instantly without animation if this value indicates false.
    ///                               When passing false, remember to use method `invalidatChart(animated:)` also
    init(currentNumber: Int, maximumNumber: Int, invalidateChartInstantly: Bool) {
        self.currentNumber = currentNumber
        self.maximumNumber = maximumNumber
        super.init()
        
        let valueText = "\(currentNumber)/\(maximumNumber)"
        valueLabel.attributedText = NSAttributedStringFactory.trackingApplied(valueText, font: valueLabel.font, tracking: 0.6)
        if invalidateChartInstantly {
            invalidateChart(animated: false)
        }
    }
    
    /// Invalidates the progress shown on the chart
    ///
    /// - Parameter animated: Indicating if invalidation should be animated
    func invalidateChart(animated: Bool) {
        let progress = Double(currentNumber) / Double(maximumNumber)
        if animated {
            animationView.play(toProgress: CGFloat(progress))
        } else {
            animationView.animationProgress = CGFloat(progress)
        }
    }
            
    /// - SeeAlso: ViewSetupable
    func setupViewHierarchy() {
        [animationView, valueLabel].forEach(addSubview)
    }
    
    /// - SeeAlso: ViewSetupable
    func setupConstraints() {
        animationView.constraintToSuperviewEdges()
        valueLabel.constraintToSuperviewEdges(excludingAnchors: [.top, .bottom], withInsets: .init(top: 0, left: 8, bottom: 0, right: 8))
        NSLayoutConstraint.activate([
            valueLabel.centerYAnchor.constraint(equalTo: animationView.centerYAnchor)
        ])
    }
    
    /// - SeeAlso: ViewSetupable
    func setupProperties() {
        animationView.loopAnimation = true
        animationView.play(toProgress: 1.0, withCompletion: nil)
        
        // TODO: For debuging purposes. Remove when lottie will be fully working
        animationView.clipsToBounds = false
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
    }
}

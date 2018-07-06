//
//  HorizontalStarsView.swift
//  CarRecognition
//


import UIKit
import Lottie

internal final class HorizontalStarsView: View, ViewSetupable {
    
    private let starCount: Int
    
    private let numberOfStars = 5
    
    private lazy var animationView = LOTAnimationView(name: "horizontal-stars").layoutable()
    
    /// Initializes the view with given parameters
    ///
    /// - Parameters:
    ///   - starCount: Count of achieved stars
    ///   - invalidateChartInstantly: Chart will be updated instantly without animation if this value indicates false.
    ///                               When passing false, remember to use method `invalidatChart(animated:)` also
    init(starCount: Int, invalidateChartInstantly: Bool) {
        guard starCount >= 0, starCount <= 5 else {
            fatalError("Wrong input provided for stars chart")
        }
        self.starCount = starCount
        super.init()
        if invalidateChartInstantly {
            invalidateChart(animated: false)
        }
    }
    
    /// Invalidates the progress shown on the chart
    ///
    /// - Parameter animated: Indicating if invalidation should be animated
    func invalidateChart(animated: Bool) {
        let progress = Double(starCount) / Double(numberOfStars)
        animationView.set(progress: CGFloat(progress), animated: animated)
    }
    
    /// - SeeAlso: ViewSetupable
    func setupViewHierarchy() {
        addSubview(animationView)
    }
    
    /// - SeeAlso: ViewSetupable
    func setupConstraints() {
        animationView.constraintToSuperviewEdges()
    }
}

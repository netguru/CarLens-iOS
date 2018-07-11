//
//  HorizontalStarsView.swift
//  CarRecognition
//


import UIKit
import Lottie

internal final class HorizontalStarsView: View, ViewSetupable {
    
    private var starCount: Int
    
    private var isLocked: Bool
    
    private let numberOfStars = 5
    
    private lazy var animationView = LOTAnimationView(name: "horizontal-stars").layoutable()
    
    /// Initializes the view with given parameters
    ///
    /// - Parameters:
    ///   - starCount: Count of achieved stars
    ///   - invalidateChartInstantly: Chart will be updated instantly without animation if this value indicates false.
    ///                               When passing false, remember to use method `invalidatChart(animated:)` also
    ///   - isLocked: Indicating if the info should be locked
    init(starCount: Int, invalidateChartInstantly: Bool, isLocked: Bool = false) {
        self.starCount = starCount
        self.isLocked = isLocked
        super.init()
        setup(starCount: starCount, invalidateChartInstantly: invalidateChartInstantly)
    }
    
    /// Setups the view with given parameters. Use only inside reusable views.
    ///
    /// - Parameters:
    ///   - starCount: Count of achieved stars
    ///   - invalidateChartInstantly: Chart will be updated instantly without animation if this value indicates false.
    ///                               When passing false, remember to use method `invalidatChart(animated:)` also
    func setup(starCount: Int, invalidateChartInstantly: Bool, isLocked: Bool = false) {
        guard starCount >= 0, starCount <= 5 else {
            fatalError("Wrong input provided for stars chart")
        }
        animationView.set(progress: 0, animated: false)
        self.starCount = starCount
        self.isLocked = isLocked
        if invalidateChartInstantly {
            invalidateChart(animated: false)
        }
    }
    
    /// Invalidates the progress shown on the chart
    ///
    /// - Parameter animated: Indicating if invalidation should be animated
    func invalidateChart(animated: Bool) {
        var progress = Double(starCount) / Double(numberOfStars + 1)
        if isLocked {
            progress = 0
        }
        animationView.set(progress: CGFloat(progress), animated: animated)
    }
    
    /// Clear the progress shown on the chart
    ///
    /// - Parameter animated: Indicating if progress change should be animated
    func clearChart(animated: Bool) {
        animationView.set(progress: 0, animated: animated)
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

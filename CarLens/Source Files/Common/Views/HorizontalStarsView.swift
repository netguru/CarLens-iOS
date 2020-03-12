//
//  HorizontalStarsView.swift
//  CarLens
//


import UIKit
import Lottie

final class HorizontalStarsView: View, ViewSetupable {

    private var starCount: Int

    private var isLocked: Bool

    private let numberOfStars = 5

    private lazy var animationView = LOTAnimationView(name: "horizontal-stars").layoutable()

    /// Initializes the view with given parameters
    ///
    /// - Parameters:
    ///   - starCount: Count of achieved stars
    ///   - setChartWithoutAnimation: Chart will be updated instantly without animation if this value indicates true.
    ///                               When passing true, remember to use method `setChart(animated:toZero:)` also
    ///   - isLocked: Indicating if the info should be locked
    init(starCount: Int, setChartWithoutAnimation: Bool = false, isLocked: Bool = false) {
        self.starCount = starCount
        self.isLocked = isLocked
        super.init()
        setup(starCount: starCount, setChartWithoutAnimation: setChartWithoutAnimation)
    }

    /// Setups the view with given parameters. Use only inside reusable views.
    ///
    /// - Parameters:
    ///   - starCount: Count of achieved stars
    ///   - setChartWithoutAnimation: Chart will be updated instantly without animation if this value indicates true.
    ///                               When passing true, remember to use method `setChart(animated:toZero:)` also
    func setup(starCount: Int, setChartWithoutAnimation: Bool, isLocked: Bool = false) {
        guard starCount >= 0, starCount <= 5 else {
            fatalError("Wrong input provided for stars chart")
        }
        animationView.set(progress: 0, animated: false)
        self.starCount = starCount
        self.isLocked = isLocked
        if setChartWithoutAnimation {
            setChart(animated: false, toZero: false)
        }
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

extension HorizontalStarsView: ViewProgressable {

	/// - SeeAlso: ViewProgressable
	func setChart(animated: Bool, toZero: Bool) {
        var progress = Double(starCount) / Double(numberOfStars + 1)
        if isLocked || toZero {
            progress = 0
        }
        animationView.set(progress: CGFloat(progress), animated: animated)
    }
}

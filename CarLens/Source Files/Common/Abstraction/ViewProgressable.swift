//
//  ViewProgressable.swift
//  CarLens
//

/// Interface for progressing the view
protocol ViewProgressable {

    /// Sets values for the chart
    ///
    /// - Parameters:
    ///   - animated: Indicating if the change should be animated
    ///   - toZero: Indicating if charts should be cleared
	func setChart(animated: Bool, toZero: Bool)
}

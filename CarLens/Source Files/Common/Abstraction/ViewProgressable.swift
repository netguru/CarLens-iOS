//
//  ViewProgressable.swift
//  CarLens
//

/// Interface for progressing the view
protocol ViewProgressable {

    /// Invalidates the progress shown on the chart
    ///
    /// - Parameter animated: Indicating if invalidation should be animated
    func invalidateChart(animated: Bool)
}

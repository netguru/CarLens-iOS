//
//  SystemMetrics.swift
//  CarRecognition
//


import Foundation

/// Enum describing the speed metrics options.
///
/// - mph: Miles per hour.
/// - kph: Kilometers per hour.
internal enum SpeedMetricsType: String {
    case mph
    case kph
}

/// A struct used for determining user's metrics.
internal struct SystemMetrics {
    
    /// The shared instance of SystemMetrics.
    static let shared: SystemMetrics = SystemMetrics()
    
    /// Current metrics used for speed.
    let speedType: SpeedMetricsType
    
    /// Initializes a new instance of SystemMetrics.
    /// - Parameter locale: the user's locale for which metrics should be configured.
    init(with locale: Locale = Locale.current) {
        self.speedType = locale.usesMetricSystem ? .kph : .mph
    }
}

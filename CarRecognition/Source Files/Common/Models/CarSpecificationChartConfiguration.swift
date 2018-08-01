//
//  CarSpecificationChartConfiguration.swift
//  CarRecognition
//


/// Model containing configuration used when displaying car specification charts
internal struct CarSpecificationChartConfiguration {
    
    /// Speed metrics type to be used for referenceSpeed calculating
    private let speedType: SpeedMetricsType
    
    /// Reference horse power that will be used as 100%
    let referenceHorsePower = 320
    
    /// Reference speed that will be used as 100% depending on the user's system metrics
    var referenceSpeed: Int {
        switch self.speedType {
        case .mph:
            return referenceSpeedInMiles
        case .kph:
            return referenceSpeedInKilometers
        }
    }
    
    /// Reference speed that will be used as 100% (in miles)
    private let referenceSpeedInMiles = 200
    
    /// Reference speed that will be used as 100% (in kilometers)
    private let referenceSpeedInKilometers = 322
    
    /// Reference engine volume that will be used as 100% (in centimeters)
    let referenceEngineVolume = 4000
    
    /// Reference accelerate time that will be used as 0% (in seconds)
    let referenceMaxAccelerate: TimeInterval = 20
    
    /// Reference accelerate time that will be used as 100% (in seconds)
    let referenceMinAccelerate: TimeInterval = 2.9
    
    /// Initializes the CarSpecificationChartConfiguration.
    ///
    /// - Parameter speedType: Speed Metrics type used for referenceSpeed calculating.
    init(with speedType: SpeedMetricsType = SystemMetrics.shared.speedType) {
        self.speedType = speedType
    }
}

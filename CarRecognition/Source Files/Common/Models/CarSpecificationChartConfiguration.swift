//
//  CarSpecificationChartConfiguration.swift
//  CarRecognition
//


/// Model containing configuration used when displaying car specification charts
internal struct CarSpecificationChartConfiguration {
    
    /// Reference horse power that will be used as 100%
    let referenceHorsePower = 300
    
    /// Reference speed that will be used as 100% (in miles)
    let referenceSpeed = 300
    
    /// Reference engine volume that will be used as 100% (in centimeters)
    let referenceEngineVolume = 5000
    
    /// Reference accelerate time that will be used as 100% (in seconds)
    let referenceAccelerate: TimeInterval = 3
}

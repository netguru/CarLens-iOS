//
//  CRTimeFormatter.swift
//  CarLens
//


internal struct CRTimeFormatter {
    
    /// Returns miliseconds formatted interval string from given time interval.
    ///
    /// - Parameter value: Value to be formatted
    /// - Returns: Formatted value.
    static func intervalMilisecondsFormatted(_ value: TimeInterval) -> String {
        let miliseconds = Int((value.truncatingRemainder(dividingBy: 1)) * 1000)
        return "\(miliseconds) ms"
    }
}

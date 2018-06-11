//
//  CRTimeFormatter.swift
//  CarRecognition
//


internal final class CRTimeFormatter {
    
    static private let dateComponentsFormatter = DateComponentsFormatter()
    
    /// Returns miliseconds formatted interval string from given time interval.
    ///
    /// - Parameter value: Value to be formatted
    /// - Returns: Formatted value. Empty in case of error.
    static func intervalMilisecondsFormatted(_ value: TimeInterval) -> String {
        let miliseconds = Int((value.truncatingRemainder(dividingBy: 1)) * 1000)
        return "\(miliseconds) ms"
    }
}

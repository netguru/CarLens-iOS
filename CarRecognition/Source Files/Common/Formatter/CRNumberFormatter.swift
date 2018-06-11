//
//  CRNumberFormatter.swift
//  CarRecognition
//


internal final class CRNumberFormatter {
    
    static private let numberFormatter = NumberFormatter()
    
    /// Returns percentage formatted string from given number.
    ///
    /// - Parameter value: Value to be formatted
    /// - Returns: Formatted value. Empty in case of error.
    static func percentageFormatted(_ value: Float) -> String {
        numberFormatter.numberStyle = .percent
        return numberFormatter.string(from: NSNumber(value: value)) ?? ""
    }
}

//
//  NSAttributedStringFactory.swift
//  CarLens
//


import UIKit.NSAttributedString

internal final class NSAttributedStringFactory {
    
    /// Available tracking types
    enum Tracking: CGFloat {
        case veryCondensed = -3
        case condensed = -0.5
        case normal = 0
    }
    
    /// Creates attributed string with applied proper kerning calculated from given Adobe tracking value
    ///
    /// - Parameters:
    ///   - text: Text to be attributed
    ///   - font: Font to be used
    ///   - tracking: Tracking type to be applied
    /// - Returns: Attributed text
    static func trackingApplied(_ text: String?, font: UIFont, tracking: Tracking) -> NSAttributedString {
        guard let text = text else { return NSAttributedString(string: "") }
        return NSAttributedString(
            string: text,
            attributes: [
                .font: font,
                .kern: tracking.rawValue,
            ]
        )
    }
}

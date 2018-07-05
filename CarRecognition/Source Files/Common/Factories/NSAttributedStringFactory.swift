//
//  NSAttributedStringFactory.swift
//  CarRecognition
//


import UIKit.NSAttributedString

internal final class NSAttributedStringFactory {
    
    /// Creates attributed string with applied proper kerning calculated from given Adobe tracking value
    ///
    /// - Parameters:
    ///   - text: Text to be attributed
    ///   - font: Font to be used
    ///   - tracking: Adobbe tracking value
    /// - Returns: Attributed text
    static func trackingApplied(_ text: String?, font: UIFont, tracking: CGFloat) -> NSAttributedString {
        let kern = font.pointSize * tracking / 1000.0
        guard let text = text else { return NSAttributedString(string: "") }
        return NSAttributedString(
            string: text,
            attributes: [
                .font: font,
                .kern: kern,
            ]
        )
    }
}

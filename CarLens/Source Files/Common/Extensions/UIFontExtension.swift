//
//  UIFontExtension.swift
//  CarLens
//


import UIKit.UIFont

internal extension UIFont {

    /// Returns the `Gliscor Gothic` font object in the specified size
    ///
    /// - Parameters:
    ///   - size: The size (in points) to which the font is scaled. This value must be greater than 0.0
    /// - Returns: Font object of the specified size
    static func gliscorGothicFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "GliscorGothic", size: size)!
    }

    /// Returns the `BLOKK Neue` font object in the specified size
    ///
    /// - Parameters:
    ///   - size: The size (in points) to which the font is scaled. This value must be greater than 0.0
    /// - Returns: Font object of the specified size
    static func blokkNeueFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "BLOKKNeue-Regular", size: size)!
    }
}

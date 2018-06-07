//
//  UIColorExtension.swift
//  CarRecognition
//


import UIKit.UIColor

internal extension UIColor {
    
    /// Convenience intitializer for hex format
    ///
    /// - Parameter hex: color in hex format (for example 0x121212)
    convenience init(hex: Int) {
        let red = CGFloat((hex >> 16) & 0xff) / 255
        let green = CGFloat((hex >> 08) & 0xff) / 255
        let blue = CGFloat((hex >> 00) & 0xff) / 255
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
}

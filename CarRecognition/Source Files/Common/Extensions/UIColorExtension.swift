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
    
    class var crBackgroundGray: UIColor {
        return .init(hex: 0xE9EEF0)
    }
    
    class var crBackgroundLightGray: UIColor {
        return .init(hex: 0xEEF3F5)
    }
    
    class var crFontDark: UIColor {
        return .init(hex: 0x1A1A1A)
    }
    
    class var crFontGray: UIColor {
        return .init(hex: 0x7994A9)
    }
    
    class var crFontLightGray: UIColor {
        return .init(hex: 0x8199AC)
    }

    class var crShadowOrange: UIColor {
        return .init(hex: 0xFF5969)
    }
    
    class var crProgressDarkGray: UIColor {
        return .init(hex: 0xC4D0D6)
    }
}

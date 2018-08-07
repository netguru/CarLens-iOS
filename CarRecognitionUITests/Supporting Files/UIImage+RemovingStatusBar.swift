//
//  UIImage+RemovingStatusBar.swift
//  CarRecognitionUITests
//


import UIKit

extension UIImage {
    
    var removingStatusBar: UIImage? {
        guard let cgImage = cgImage, let window = UIApplication.shared.keyWindow else { return nil }
        let isIPhoneX = window.frame.size == CGSize(width: 1125, height: 2436)
        let yOffset = Int((isIPhoneX ? 44 : 20) * scale)
        let rect = CGRect(x: 0, y: yOffset, width: cgImage.width, height: cgImage.height - yOffset)
        if let croppedCGImage = cgImage.cropping(to: rect) {
            return UIImage(cgImage: croppedCGImage, scale: scale, orientation: imageOrientation)
        }
        return nil
    }
}

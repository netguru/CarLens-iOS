//
//  UIImageExtension.swift
//  CarRecognition
//


import UIKit
import VideoToolbox

extension UIImage {
    
    /// Initialized the UIImage from given pixel buffer.
    /// Works only for RGB pixel buffers.
    ///
    /// - Parameter pixelBuffer: Pixel buffer to be transformed
    public convenience init?(pixelBuffer: CVPixelBuffer) {
        var cgImage: CGImage?
        VTCreateCGImageFromCVPixelBuffer(pixelBuffer, nil, &cgImage)
        
        if let cgImage = cgImage {
            self.init(cgImage: cgImage)
        } else {
            return nil
        }
    }
}

//
//  ARAnchorExtension.swift
//  CarRecognition
//


import ARKit

internal extension ARAnchor {
    
    /// Calculates distance between current anchor and given one
    ///
    /// - Parameter anchor: Anchor to calculate distance to
    /// - Returns: Calculated distance in meters
    func distance(from anchor: ARAnchor) -> Float {
        return simd_distance(transform.columns.3, anchor.transform.columns.3)
    }
}

//
//  ARAnchorExtension.swift
//  CarLens
//


import ARKit

internal extension ARAnchor {

    /// Initializes Augemnted Reality anchor from given parameters
    ///
    /// - Parameters:
    ///   - hitTest: Result of the hit test
    ///   - camera: Camera used for the hit test
    ///   - nodeShift: Shift to be applied to the anchor
    convenience init(from hitTest: ARHitTestResult, camera: ARCamera, nodeShift: NodeShift) {
        var translation = matrix_identity_float4x4
        translation.columns.3.z = Float(-hitTest.distance) - nodeShift.depth
        translation.columns.3.x = -nodeShift.elevation
        let transform = simd_mul(camera.transform, translation)
        self.init(transform: transform)
    }

    /// Calculates distance between current anchor and given one
    ///
    /// - Parameter anchor: Anchor to calculate distance to
    /// - Returns: Calculated distance in meters
    func distance(from anchor: ARAnchor) -> Float {
        return simd_distance(transform.columns.3, anchor.transform.columns.3)
    }
}

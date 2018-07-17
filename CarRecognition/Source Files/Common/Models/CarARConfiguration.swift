//
//  CarARConfiguration.swift
//  CarRecognition
//


import UIKit

/// Model containing configuration used for application augmented reality view
internal struct CarARConfiguration {
    
    /// Node shift from the place of detected anchor
    let nodeShift: NodeShift
    
    /// Minimum distance from the device that allow pinning nodes
    let minimumDistanceFromDevice: CGFloat
    
    /// Maximum distance from the device that allow pinning nodes
    let maximumDistanceFromDevice: CGFloat
    
    /// Minimum distance between existing nodes that allows pinning another one
    let minimumDistanceBetweenNodes: Float
    
    /// Place for doing the hit test
    let pointForHitTest = CGPoint(x: 0.5, y: 0.5)
    
    /// Minimum confidence nedded to pin the label
    let neededConfidenceToPinLabel = 0.96
    
    /// Number of last values that should be normalized
    let normalizationCount = 10
    
    init() {
        #if ENV_DEVELOPMENT
            nodeShift = NodeShift(depth: 0, elevation: 0)
            minimumDistanceFromDevice = 0.1
            minimumDistanceBetweenNodes = 0.2
            maximumDistanceFromDevice = 2
        #else
            nodeShift = NodeShift(depth: 1, elevation: 1.5)
            minimumDistanceFromDevice = 0.5
            minimumDistanceBetweenNodes = 2
            maximumDistanceFromDevice = 5
        #endif
    }
}

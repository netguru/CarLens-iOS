//
//  UIPanGestureRecognizerExtensions.swift
//  CarLens
//


import UIKit

/// Enum describing possible Pan Gesture directions
///
/// - undefined: undefined state
/// - bottomToTop: pan gesture from bottom to top
/// - topToBottom: pan gesture from top to bottom
/// - rightToLeft: pan gesture from right to left
/// - leftToRight: pan gesture from left to right
enum UIPanGestureRecognizerDirection {
    case undefined
    case bottomToTop
    case topToBottom
    case rightToLeft
    case leftToRight
}

extension UIPanGestureRecognizer {

    /// Holds information about the direction of Pan gesture
    var direction: UIPanGestureRecognizerDirection {
        let velocity = self.velocity(in: view)
        let isVertical = abs(velocity.y) > abs(velocity.x)

        let direction: UIPanGestureRecognizerDirection

        if isVertical {
            direction = velocity.y > 0 ? .topToBottom : .bottomToTop
        } else {
            direction = velocity.x > 0 ? .leftToRight : .rightToLeft
        }
        return direction
    }
}

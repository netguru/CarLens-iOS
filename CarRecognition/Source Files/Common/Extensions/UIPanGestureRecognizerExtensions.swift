//
//  UIPanGestureRecognizerExtensions.swift
//  CarRecognition
//


import UIKit

public enum UIPanGestureRecognizerDirection {
    case undefined
    case bottomToTop
    case topToBottom
    case rightToLeft
    case leftToRight
}

internal extension UIPanGestureRecognizer {
    var direction: UIPanGestureRecognizerDirection {
        let velocity = self.velocity(in: view)
        let isVertical = fabs(velocity.y) > fabs(velocity.x)

        var direction: UIPanGestureRecognizerDirection

        if isVertical {
            direction = velocity.y > 0 ? .topToBottom : .bottomToTop
        } else {
            direction = velocity.x > 0 ? .leftToRight : .rightToLeft
        }
        return direction
    }
}

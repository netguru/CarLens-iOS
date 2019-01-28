//
//  CarImage.swift
//  CarLens
//

import UIKit.UIImage

/// Internal struct that holds information about locked and unlocked images for concrete car
struct CarImage: Equatable {
    let unlocked: UIImage
    let locked: UIImage
    let logoUnlocked: UIImage
    let logoLocked: UIImage

    /// SeeAlso: Equatable
    static func == (lhs: CarImage, rhs: CarImage) -> Bool {
        return lhs.unlocked == rhs.unlocked &&
            lhs.locked == rhs.locked &&
            lhs.logoUnlocked == rhs.logoUnlocked &&
            lhs.logoLocked == rhs.logoLocked
    }

}

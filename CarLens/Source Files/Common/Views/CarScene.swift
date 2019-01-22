//
//  CarScene.swift
//  CarLens
//


import SpriteKit

final class CarScene: SKScene {

    /// Callback called when user tapped AR pin with given car id
    var didTapCar: ((String) -> Void)?

    /// Callback called when user tapped view excluding the AR pin
    var didTapBackgroundView: (() -> Void)?

    /// SeeAlso: SKScene
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        var didTapCarLabel = false
        for touch in touches {
            for node in nodes(at: touch.location(in: self)) {
                guard let carId = node.name else { continue }
                didTapCar?(carId)
                didTapCarLabel = true
            }
        }
        guard !didTapCarLabel else { return }
        didTapBackgroundView?()
    }
}

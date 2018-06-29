//
//  SKNodeFactory.swift
//  CarRecognition
//


import SpriteKit

/// Factory for creating SpriteKit nodes
internal final class SKNodeFactory {
    
    /// Creates node with label of detected car
    ///
    /// - Returns: Created car node
    static func car(labeled label: String) -> SKNode {
        let labelNode = SKLabelNode(text: label)
        labelNode.horizontalAlignmentMode = .center
        labelNode.verticalAlignmentMode = .center
        labelNode.fontColor = .black
        #if ENV_DEVELOPMENT
            labelNode.fontSize = 10
        #else
            labelNode.fontSize = 70
        #endif
        
        let backgroundSize = CGSize(width: labelNode.frame.size.width * 1.4, height: labelNode.frame.size.height * 1.5)
        let roundedShapeNode = SKShapeNode(rectOf: backgroundSize, cornerRadius: backgroundSize.height / 2)
        roundedShapeNode.fillColor = .white
        let cropNode = SKCropNode()
        cropNode.maskNode = roundedShapeNode
        let backgroundNode = SKSpriteNode(color: .white, size: backgroundSize)
        
        cropNode.addChild(backgroundNode)
        backgroundNode.addChild(labelNode)
        return cropNode
    }
}

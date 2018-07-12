//
//  SKNodeFactory.swift
//  CarRecognition
//


import SpriteKit
import UIKit

/// Factory for creating SpriteKit nodes
internal final class SKNodeFactory {
    
    private var labelFontSize: CGFloat {
        #if ENV_DEVELOPMENT
            return 10
        #else
            return 70
        #endif
    }
    
    private lazy var imagePinSize = CGSize(width: labelBackgroundHeight * 3, height: labelBackgroundHeight * 3)
    
    private lazy var makeImageSize = CGSize(width: labelBackgroundHeight * 0.7, height: labelBackgroundHeight * 0.7)
    
    private lazy var labelBackgroundHeight: CGFloat = labelFontSize * 1.5
    
    /// Creates node with label of detected car
    ///
    /// - Returns: Created car node
    func node(for car: Car) -> SKNode {
        let backgroundSize = CGSize(width: getWidthOfLabel(withText: car.model) * 3, height: labelBackgroundHeight)

//        let roundedShapeNode = SKShapeNode(rectOf: backgroundSize, cornerRadius: backgroundSize.height / 2)
//        roundedShapeNode.fillColor = .black
//        let cropNode = SKCropNode()
//        cropNode.maskNode = roundedShapeNode
        
        let node = SKNode()
        
        let backgroundNode = SKSpriteNode(color: .black, size: backgroundSize)
        backgroundNode.alpha = 0.25
        
        let imagePinNode = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "ar-pin")), size: imagePinSize)
        
        let makeImageNode = SKSpriteNode(texture: SKTexture(image: car.image.logoUnlocked), size: makeImageSize)
        
        let labelNode = SKLabelNode(text: car.model.capitalized)
        labelNode.horizontalAlignmentMode = .center
        labelNode.verticalAlignmentMode = .center
        labelNode.fontColor = .white
        labelNode.fontSize = labelFontSize
//        labelNode.position = .init(x: 0.5, y: 0.5)
        
//        backgroundNode.zPosition = 0
//        labelNode.zPosition = 1
        
        
//        cropNode.addChild(backgroundNode)
        node.addChild(backgroundNode)
        node.addChild(imagePinNode)
        node.addChild(makeImageNode)
        node.addChild(labelNode)
//        backgroundNode.addChild(labelNode)
        return node
    }
    
    private func getWidthOfLabel(withText text: String) -> CGFloat {
        let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: labelBackgroundHeight)
        let font = UIFont.systemFont(ofSize: labelFontSize)
        let boundingBox = text.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return ceil(boundingBox.width)
    }
}

//
//  SKNodeFactory.swift
//  CarLens
//


import SpriteKit
import UIKit

/// Factory for creating SpriteKit nodes
final class SKNodeFactory {

    private enum Constants {
        static let blurType = "CIGaussianBlur"
        static let blurRadusValue = NSNumber(value: 10)
        static let blurRadiusKey = "inputRadius"
        static let blurBackgroundColor = UIColor(hex: 0x808080)
    }

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
        let node = SKNode()
        let backgroundSize = CGSize(width: getWidthOfLabel(withText: car.model) * 2.5, height: labelBackgroundHeight)

        let backgroundNode = SKSpriteNode(color: .white, size: backgroundSize)
        backgroundNode.alpha = 0.25
        let backgroundBlurredNode = SKSpriteNode(color: Constants.blurBackgroundColor, size: backgroundSize)

        // Apply blur
        let blurNode = SKEffectNode()
        blurNode.shouldEnableEffects = true
        let filter = CIFilter(name: Constants.blurType)!
        filter.setDefaults()
        filter.setValue(Constants.blurRadusValue, forKey: Constants.blurRadiusKey)
        blurNode.filter = filter
        blurNode.addChild(backgroundBlurredNode)

        // Apply corner radius
        let roundedShapeNode = SKShapeNode(rectOf: backgroundSize, cornerRadius: backgroundSize.height / 2)
        roundedShapeNode.fillColor = .black
        let cropNode = SKCropNode()
        cropNode.maskNode = roundedShapeNode
        cropNode.addChild(backgroundNode)
        cropNode.addChild(blurNode)

        let imagePinNode = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "ar-pin")), size: imagePinSize)
        imagePinNode.position = .init(x: -(backgroundSize.width / 2 - makeImageSize.width / 8), y: 0)

        let makeImageNode = SKSpriteNode(texture: SKTexture(image: car.image.logoUnlocked), size: makeImageSize)
        makeImageNode.position = .init(x: (backgroundSize.width / 2 - makeImageSize.width / 1.5), y: 0)

        let labelNode = SKLabelNode(text: car.model.capitalized)
        labelNode.fontName = UIFont.systemFont(ofSize: labelFontSize).fontName
        labelNode.horizontalAlignmentMode = .center
        labelNode.verticalAlignmentMode = .center
        labelNode.fontColor = .white
        labelNode.fontSize = labelFontSize

        node.addChild(cropNode)
        node.addChild(imagePinNode)
        node.addChild(makeImageNode)
        node.addChild(labelNode)

        node.name = car.id
        return node
    }

    private func getWidthOfLabel(withText text: String) -> CGFloat {
        let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: labelBackgroundHeight)
        let font = UIFont.systemFont(ofSize: labelFontSize)
        let boundingBox = text.boundingRect(with: constraintRect,
                                            options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                            attributes: [.font: font],
                                            context: nil)
        return ceil(boundingBox.width)
    }
}

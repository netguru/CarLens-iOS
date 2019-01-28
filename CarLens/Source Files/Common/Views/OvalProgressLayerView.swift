//
//  OvalProgressLayerView.swift
//  CarLens
//


import UIKit

final class OvalProgressLayerView: View {

    private enum Constants {
        static let animationKey = "strokeEnd"
        static let fullOvalStartAngle: CGFloat = 3/2 * .pi
    }

    private let startAngle: CGFloat

    private let endAngle: CGFloat

    private let progressStrokeColor: UIColor

    private let trackStrokeColor: UIColor

    private let lineWidth: CGFloat

    private let animationDuration: Double

    private let progressLayer = CAShapeLayer()

    /// Initializes the view with given angles and stroke color
    ///
    /// - Parameters:
    ///   - startAngle: Starting angle of layer
    ///   - endAngle: Ending angle of layer
    ///   - animationDuration: Duration of the progress animation
    ///   - lineWidth: Width of line
    ///   - progressStrokeColor: Color of progress stroke
    ///   - trackStrokeColor: Color of track stroke
    init(startAngle: CGFloat,
         endAngle: CGFloat,
         animationDuration: Double = 0.5,
         lineWidth: CGFloat = 6,
         progressStrokeColor: UIColor,
         trackStrokeColor: UIColor = .crProgressDarkGray) {
        self.startAngle = startAngle
        self.endAngle = endAngle
        self.animationDuration = animationDuration
        self.lineWidth = lineWidth
        self.progressStrokeColor = progressStrokeColor
        self.trackStrokeColor = trackStrokeColor
        super.init()
    }

    /// - SeeAlso: UIView.layoutSubviews()
    override func layoutSubviews() {
        super.layoutSubviews()
        drawCustomLayer()
    }
}

extension OvalProgressLayerView {

    /// Set progress value either animated or not animated
    func set(progress: Double, animated: Bool) {
        guard animated else {
            progressLayer.isHidden = progress == 0
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            progressLayer.strokeEnd = CGFloat(progress)
            CATransaction.commit()
            return
        }
        progressLayer.isHidden = false
        let initialAnimation = CABasicAnimation(keyPath: Constants.animationKey)
        initialAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        initialAnimation.toValue = progress
        initialAnimation.duration = animationDuration
        initialAnimation.fillMode = CAMediaTimingFillMode.forwards
        initialAnimation.isRemovedOnCompletion = false

        progressLayer.add(initialAnimation, forKey: "PartOvalProgressView.ProgressLayer.animation")
    }

    private func drawCustomLayer() {
        let circularPath = UIBezierPath(arcCenter: center,
                                        radius: bounds.height / 2.2,
                                        startAngle: startAngle,
                                        endAngle: endAngle,
                                        clockwise: true)
        let trackLayer = CAShapeLayer()
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = trackStrokeColor.cgColor
        trackLayer.lineWidth = lineWidth
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = CAShapeLayerLineCap.round
        layer.addSublayer(trackLayer)

        progressLayer.path = circularPath.cgPath
        progressLayer.strokeColor = progressStrokeColor.cgColor
        progressLayer.lineWidth = lineWidth
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = CAShapeLayerLineCap.round

        let gradientLayer = generateGradient()
        gradientLayer.mask = progressLayer

        layer.addSublayer(gradientLayer)
    }

    private func generateGradient() -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()

        /// Checks if start angle is indicating that it is full oval instead of of partial oval progress view
        if startAngle == Constants.fullOvalStartAngle {
            gradientLayer.startPoint = CGPoint(x: 1, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 0, y: 0.5)
        } else {
            gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        }
        gradientLayer.colors = [UIColor.crShadowOrange.cgColor, UIColor.crDeepOrange.cgColor]
        gradientLayer.frame = bounds

        return gradientLayer
    }
}

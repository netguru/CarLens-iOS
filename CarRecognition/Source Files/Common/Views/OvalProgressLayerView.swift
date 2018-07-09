//
//  OvalProgressLayerView.swift
//  CarRecognition
//


import UIKit

final class OvalProgressLayerView: View {
    
    private struct Constants {
        static let animationKey = "strokeEnd"
    }

    private let startAngle: CGFloat

    private let endAngle: CGFloat

    private let progressStrokeColor: UIColor
    
    private let trackStrokeColor: UIColor

    private let progressLayer = CAShapeLayer()
    
    /// Initializes the view with given angles and stroke color
    ///
    /// - Parameters:
    ///   - startAngle: Starting angle of layer
    ///   - endAngle: ending angle of layer
    ///   - strokeColor: Color of stroke in oval layer
    init(startAngle: CGFloat, endAngle: CGFloat, progressStrokeColor: UIColor, trackStrokeColor: UIColor = UIColor.crBackgroundGray) {
        self.startAngle = startAngle
        self.endAngle = endAngle
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
    private func drawCustomLayer() {
        let circularPath = UIBezierPath(arcCenter: center,
                                        radius: bounds.height / 2,
                                        startAngle: startAngle,
                                        endAngle: endAngle,
                                        clockwise: true)
        let trackLayer = CAShapeLayer()
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = trackStrokeColor.cgColor
        trackLayer.lineWidth = 6
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = kCALineCapRound
        layer.addSublayer(trackLayer)
        
        progressLayer.path = circularPath.cgPath
        progressLayer.strokeColor = progressStrokeColor.cgColor
        progressLayer.lineWidth = 6
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = kCALineCapRound
        progressLayer.strokeEnd = 0
        layer.addSublayer(progressLayer)
    }
    
    /// Set progress value either animated or not animated
    internal func setProgress(progress: Double, animated: Bool) {
        guard animated else {
            progressLayer.strokeEnd = CGFloat(progress)
            return
        }
        let initialAnimation = CABasicAnimation(keyPath: Constants.animationKey)
        initialAnimation.toValue = progress
        initialAnimation.duration = 1.5
        initialAnimation.fillMode = kCAFillModeForwards
        initialAnimation.isRemovedOnCompletion = false
        
        progressLayer.add(initialAnimation, forKey: "PartOvalProgressView.ProgressLayer.animation")
    }
}

//
//  LiveVideoView.swift
//  CarRecognition
//


import UIKit

internal final class LiveVideoView: View, ViewSetupable {

    /// Button for test
    lazy var testButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Localizable.Common.confirm, for: .normal)
        button.tintColor = .blue
        return button.layoutable()
    }()
    
    /// - SeeAlso: ViewSetupable
    func setupViewHierarchy() {
        addSubview(testButton)
    }
    
    /// - SeeAlso: ViewSetupable
    func setupConstraints() {
        testButton.constraintCenterToSuperview()
    }
}

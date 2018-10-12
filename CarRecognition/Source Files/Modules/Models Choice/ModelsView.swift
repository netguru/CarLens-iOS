//
//  ModelsView.swift
//  CarRecognition
//


import Foundation
import UIKit

class ModelsView: View, ViewSetupable {
    
    let buttons: [UIButton] = {
        var array: [UIButton] = []
        for _ in 0...5 {
            array.append(UIButton().layoutable())
        }
        return array
    }()
    
    private lazy var buttonsStackView = UIStackView.make(
        axis: .vertical,
        with: self.buttons,
        spacing: 5,
        distribution: .fillEqually
        ).layoutable()
    
    func setupViewHierarchy() {
        addSubview(buttonsStackView)
    }
    
    func setupConstraints() {
        buttonsStackView.constraintToSuperviewEdges()
    }
    
    func setupProperties() {
        for (i, button) in buttons.enumerated() {
            let model = TestingModel(rawValue: i)
            button.setTitle(model!.name, for: .normal)
            button.tag = i
            button.setTitleColor(.blue, for: .normal)
            button.backgroundColor = .yellow
        }
    }
    
}

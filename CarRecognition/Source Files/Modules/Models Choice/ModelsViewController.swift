//
//  ModelsViewController.swift
//  CarRecognition
//


import Foundation
import UIKit

class ModelsViewController: TypedViewController<ModelsView> {
    
    var eventTriggered: ((TestingModel) -> ())?
    
    override func viewDidLoad() {
        for button in customView.buttons {
            button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        }
        view.accessibilityIdentifier = "onboarding/view"
    }
    
    @objc private func didTapButton(_ sender: UIButton) {
        print(sender.tag)
        eventTriggered?(TestingModel(rawValue: sender.tag)!)
    }
}

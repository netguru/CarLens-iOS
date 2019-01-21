//
//  ToastDisplayer.swift
//  CarLens
//

import UIKit

struct ToastDisplayer {
    
    private struct Constants {
        static let attachPinErrorLabelHeight: CGFloat = 40
        static let attachPinErrorLabelFontSize: CGFloat = 20
        static let animationDuration = 0.3
    }
    
    private static var toastLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .black
        label.alpha = 0.0
        label.layer.cornerRadius = Constants.attachPinErrorLabelHeight / 2.0
        label.clipsToBounds = true
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    static func show(in view: UIView, text: String) {
        toastLabel.text = text
        
        view.addSubview(toastLabel)
        
        toastLabel.constraintCenterToSuperview(axis: [.horizontal])
        NSLayoutConstraint.activate([
            toastLabel.heightAnchor.constraint(equalToConstant: Constants.attachPinErrorLabelHeight),
            toastLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            toastLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
        toastLabel.heightAnchor.constraint(equalToConstant: Constants.attachPinErrorLabelHeight)
        toastLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9)
        
        UIView.animate(withDuration: Constants.animationDuration, delay: 1.0, options: [], animations: {
            self.toastLabel.alpha = 0.8
        }) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                UIView.animate(withDuration: Constants.animationDuration, animations: {
                    self.toastLabel.alpha = 0.0
                }) { _ in
                   self.toastLabel.removeFromSuperview()
                }
            })
        }
    }
}

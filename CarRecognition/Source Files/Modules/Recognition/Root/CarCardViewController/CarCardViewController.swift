//
//  CarCardViewController.swift
//  CarRecognition
//


import UIKit

internal final class CarCardViewController: TypedViewController<CarCardView> {
    
    /// SeeAlso: UIViewController
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupLayout()
    }
    
    func setupAnimation() {
        UIView.animate(withDuration: 0.8) {
            let frame = self.view.frame
            let yComponent: CGFloat = UIScreen.main.bounds.height / 2
            self.view.frame = CGRect(x: 0, y: yComponent, width: frame.width, height: frame.height)
            print(self.view.frame)
        }
    }
    
    private func setupLayout() {
        view.backgroundColor = .clear
    }
}


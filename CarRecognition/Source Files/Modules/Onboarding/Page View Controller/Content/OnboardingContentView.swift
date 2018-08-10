//
//  OnboardingView.swift
//  CarRecognition
//


import UIKit

final class OnboardingContentView: View, ViewSetupable {
    
    lazy var mainImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view.layoutable()
    }()
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        return view.layoutable()
    }()
    
    lazy var infoLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.numberOfLines = 0
        return view.layoutable()
    }()
    
    // MARK: - Setup
    
    func setupViewHierarchy() {
        [mainImageView, titleLabel, infoLabel].forEach { addSubview($0) }
    }
    
    func setupProperties() {
//        backgroundColor = .red
    }
    
    func setupConstraints() {
        mainImageView.constraintCenterToSuperview(axis: [.horizontal])
        mainImageView.bottomAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        titleLabel.constraintCenterToSuperview(withConstant: CGPoint(x: 0, y: frame.height / 10.0))
        
        infoLabel.constraintCenterToSuperview(axis: [.horizontal])
        infoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30.0).isActive = true
        infoLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.7).isActive = true
    }
}

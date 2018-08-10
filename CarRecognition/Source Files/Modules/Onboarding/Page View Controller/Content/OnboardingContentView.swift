//
//  OnboardingView.swift
//  CarRecognition
//


import UIKit

internal final class OnboardingContentView: View, ViewSetupable {
    
    lazy var mainImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view.layoutable()
    }()
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 22)
        return view.layoutable()
    }()
    
    lazy var infoLabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red:0.41, green:0.51, blue:0.59, alpha:1)
        view.numberOfLines = 3
        return view.layoutable()
       
    }()
    
    // MARK: - Setup
    /// Setup method for the view
    ///
    /// - Parameters:
    ///  - image: Image to be used for an onboarding information.
    ///  - titleText: The text to be set as a title.
    ///  - infoText: The description label text.
    func setup(with image: UIImage, titleText: String, infoText: String) {
        mainImageView.image = image
        titleLabel.text = titleText
        infoLabel.attributedText = NSAttributedString(string: infoText)
                                                        .withKerning(-0.15)
                                                        .withLineSpacing(1.5, NSTextAlignment.center)
                                                        .withFont(.systemFont(ofSize: 16))
    }
    
    func setupViewHierarchy() {
        [mainImageView, titleLabel, infoLabel].forEach { addSubview($0) }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -50),
                mainImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4),
                mainImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 32),
                mainImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -32),
                titleLabel.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 50),
                titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                infoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32),
                infoLabel.widthAnchor.constraint(equalTo: mainImageView.widthAnchor, multiplier: 0.75),
                infoLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
    }
}

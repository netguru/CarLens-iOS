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
        view.textColor = UIColor.crFontLightGray
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
                mainImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -20),
                mainImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4),
                mainImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
                mainImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
                titleLabel.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 60),
                titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                infoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32),
                infoLabel.widthAnchor.constraint(equalTo: mainImageView.widthAnchor, multiplier: 0.75),
                infoLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
    }
}

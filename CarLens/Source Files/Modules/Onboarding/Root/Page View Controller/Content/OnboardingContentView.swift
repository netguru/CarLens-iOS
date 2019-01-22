//
//  OnboardingView.swift
//  CarLens
//


import UIKit

final class OnboardingContentView: View, ViewSetupable {

    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 22, weight: .semibold)
        view.textColor = UIColor.crOnboardingFontDarkGray
        return view.layoutable()
    }()

    lazy var infoLabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor.crOnboardingFontLightGray
        view.numberOfLines = 0
        return view.layoutable()
    }()

    // MARK: - Setup
    /// Setup method for the view
    ///
    /// - Parameters:
    ///  - image: Image to be used for an onboarding information.
    ///  - titleText: The text to be set as a title.
    ///  - infoText: The description label text.
    func setup(with titleText: String, infoText: String) {
        titleLabel.text = titleText
        infoLabel.attributedText = NSAttributedString(string: infoText)
                                        .withKerning(-0.15)
                                        .withLineSpacing(4.5, NSTextAlignment.center)
                                        .withFont(.systemFont(ofSize: 16))
    }

    func setupViewHierarchy() {
        [titleLabel, infoLabel].forEach { addSubview($0) }
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
                titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                titleLabel.bottomAnchor.constraint(equalTo: infoLabel.topAnchor, constant: -28),
                infoLabel.widthAnchor.constraint(greaterThanOrEqualTo: widthAnchor, multiplier: 0.6),
                infoLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                infoLabel.bottomAnchor.constraint(equalTo: bottomAnchor) ])
    }
}

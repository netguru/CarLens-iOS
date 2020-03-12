//
//  CarListNavigationBar.swift
//  CarLens
//


import UIKit

final class CarListNavigationBar: View, ViewSetupable {

    private let maximumNumber: Int

    private let currentNumber: Int

    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = .gliscorGothicFont(ofSize: 22)
        view.textColor = .black
        view.textAlignment = .center
        view.attributedText = NSAttributedStringFactory.trackingApplied(Localizable.CarsList.title.uppercased(),
                                                                        font: view.font,
                                                                        tracking: .condensed)
        return view.layoutable()
    }()

    /// Back button with arrow
    let backButton: UIButton = {
        let view = UIButton()
        view.setImage(#imageLiteral(resourceName: "button-back-arrow"), for: .normal)
        return view.layoutable()
    }()

    /// Progress view displayed as full oval figure
    lazy var progressView = FullOvalProgressView(currentNumber: currentNumber,
                                                 maximumNumber: maximumNumber).layoutable()

    /// Initializes CarListNavigationBar
    ///
    /// - Parameters:
    ///   - currentNumber: Current value of progress view
    ///   - maximumNumber: Maximum value of progress view
    init(currentNumber: Int, maximumNumber: Int) {
        self.maximumNumber = maximumNumber
        self.currentNumber = currentNumber
        super.init()

        accessibilityIdentifier = "carsList/navigationBar/main"
    }

    /// - SeeAlso: ViewSetupable
    func setupViewHierarchy() {
        [titleLabel, backButton, progressView].forEach(addSubview)
    }

    /// - SeeAlso: ViewSetupable
    func setupConstraints() {
        titleLabel.constraintCenterToSuperview()
        backButton.constraintToSuperviewEdges(excludingAnchors: [.right],
                                              withInsets: .init(top: 25, left: 37, bottom: 25, right: 0))
        backButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        progressView.constraintToSuperviewEdges(excludingAnchors: [.left],
                                                withInsets: .init(top: 10, left: 0, bottom: 10, right: 37))
        progressView.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
}

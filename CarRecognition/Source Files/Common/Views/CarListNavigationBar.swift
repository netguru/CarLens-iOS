//
//  CarListNavigationBar.swift
//  CarRecognition
//


import UIKit

internal final class CarListNavigationBar: View, ViewSetupable {

    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = .gliscorGothicFont(ofSize: 22)
        view.textColor = .black
        view.textAlignment = .center
        view.attributedText = NSAttributedStringFactory.trackingApplied(Localizable.CarsList.title.uppercased(), font: view.font, tracking: 0.6)
        return view.layoutable()
    }()
    
    internal let backButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "button-back-arrow"), for: .normal)
        return button.layoutable()
    }()
    
    /// - SeeAlso: ViewSetupable
    func setupViewHierarchy() {
        [titleLabel, backButton].forEach(addSubview)
    }
    
    /// - SeeAlso: ViewSetupable
    func setupConstraints() {
        titleLabel.constraintCenterToSuperview()
        backButton.constraintToSuperviewEdges(excludingAnchors: [.right], withInsets: .init(top: 25, left: 37, bottom: 25, right: 0))
        backButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
    }
}

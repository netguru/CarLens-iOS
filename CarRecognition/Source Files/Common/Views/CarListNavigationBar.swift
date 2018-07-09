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
    
    /// - SeeAlso: ViewSetupable
    func setupViewHierarchy() {
        addSubview(titleLabel)
    }
    
    /// - SeeAlso: ViewSetupable
    func setupConstraints() {
        titleLabel.constraintCenterToSuperview()
    }
}

//
//  CameraAccessView.swift
//  CarLens
//


import UIKit

final class CameraAccessView: View, ViewSetupable {

    /// Struct with view's dimensions
    enum Dimensions {
        static let topOfffset = UIScreen.main.bounds.height * 0.25
        static let informationFontSize: CGFloat = 16
    }

    /// Cars list button in the left bottom corner
    let carsListButton: UIButton = {
        let view = UIButton(type: .system)
        view.setImage(#imageLiteral(resourceName: "button-car-list-gray"), for: .normal)
        return view.layoutable()
    }()

     /// Access button in the bottom center
    let accessButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle(Localizable.CameraAccess.accessButton, for: .normal)
        view.setTitleColor(UIColor(hex: 0xFF6163), for: .normal)
        return view.layoutable()
    }()

    private let cameraImageView: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "camera-image")
        return view.layoutable()
    }()

    private let informationLabel: UILabel = {
        let view = UILabel()
        view.text = Localizable.CameraAccess.information
        view.font = UIFont.systemFont(ofSize: Dimensions.informationFontSize)
        view.textAlignment = .center
        view.numberOfLines = 0
        view.textColor = .white
        return view.layoutable()
    }()

    /// - SeeAlso: ViewSetupable
    func setupViewHierarchy() {
        [cameraImageView, informationLabel, accessButton, carsListButton].forEach(addSubview)
    }

    /// - SeeAlso: ViewSetupable
    func setupConstraints() {
        cameraImageView.constraintToSuperviewEdges(excludingAnchors: [.bottom],
                                                   withInsets: .init(top: Dimensions.topOfffset, left: 44,
                                                                     bottom: 0, right: 44))

        NSLayoutConstraint.activate([
            informationLabel.topAnchor.constraint(equalTo: cameraImageView.bottomAnchor, constant: 43),
            accessButton.topAnchor.constraint(equalTo: informationLabel.bottomAnchor, constant: 38),
            carsListButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            carsListButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
        informationLabel.constraintToSuperviewEdges(excludingAnchors: [.top, .bottom],
                                                    withInsets: .init(top: 0, left: 88, bottom: 0, right: 88))
        carsListButton.constraintToConstant(.init(width: 45, height: 45))
        accessButton.constraintToSuperviewEdges(excludingAnchors: [.top, .bottom],
                                                withInsets: .init(top: 0, left: 100, bottom: 0, right: 100))
    }

    /// - SeeAlso: ViewSetupable
    func setupProperties() {
        backgroundColor = UIColor(hex: 0x2F3031)
    }
}

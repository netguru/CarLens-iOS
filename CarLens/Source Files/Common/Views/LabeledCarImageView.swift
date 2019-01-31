//
//  LabeledCarImageView.swift
//  CarLens
//


import UIKit

final class LabeledCarImageView: View, ViewSetupable {

    private lazy var modelLabel: UILabel = {
        let view = UILabel()
        view.font = .gliscorGothicFont(ofSize: UIDevice.screenSizeBiggerThan4Inches ? 102 : 72)
        view.textColor = UIColor(hex: 0xC4D0D6)
        view.numberOfLines = 1
        view.textAlignment = .center
        return view.layoutable()
    }()

    private lazy var carImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view.layoutable()
    }()

    /// Initializes the view with given car
    ///
    /// - Parameter car: Car to be used for updating the view
    init(car: Car? = nil) {
        super.init()
        guard let car = car else { return }
        setup(with: car)
    }

    /// Setups the view with given car. Use only inside reusable views.
    ///
    /// - Parameter car: Car to be used for updating the view
    func setup(with car: Car) {
        modelLabel.attributedText = NSAttributedStringFactory.trackingApplied(car.model.uppercased(),
                                                                              font: modelLabel.font,
                                                                              tracking: .veryCondensed)
        carImageView.image = car.isDiscovered ? car.image.unlocked : car.image.locked
    }

    /// - SeeAlso: ViewSetupable
    func setupViewHierarchy() {
        [modelLabel, carImageView].forEach(addSubview)
    }

    /// - SeeAlso: ViewSetupable
    func setupConstraints() {
        modelLabel.constraintCenterToSuperview(withConstant: .init(x: 0, y: -40))
        carImageView.constraintCenterToSuperview(withConstant: .init(x: 0,
                                                                     y: UIDevice.screenSizeBiggerThan4Inches ? 20 : 15))
        carImageView.constraintToConstant(.init(width: 320, height: 220))
    }

    /// - SeeAlso: ViewSetupable
    func setupProperties() {
        backgroundColor = .clear
    }
}

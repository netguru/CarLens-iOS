//
//  CarCardView.swift
//  CarRecognition
//


import UIKit

internal final class CarCardView: View, ViewSetupable {

    /// Struct which holds informations about view dimensions
    struct Dimensions {
        static let topBeamHorizontalInset = UIScreen.main.bounds.width * 0.4
        static let stackViewWidth = UIScreen.main.bounds.width * 0.8
        static let stackViewHeight = (UIScreen.main.bounds.height / 12)
        static let regularButtonDimension = 45.0
        static let bigButtonDimension = 65.0
    }

    /// Car instance
    private let car: Car

    /// Main container of the view
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 14.0
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        return view.layoutable()
    }()
    
    private let gradientView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: (UIScreen.main.bounds.height / 2) - 140, width: UIScreen.main.bounds.width, height: 140))
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 140)
        gradient.colors = [
            UIColor.white.cgColor,
            UIColor(red: 0.94, green: 0.96, blue: 0.96, alpha: 1).cgColor
        ]
        gradient.locations = [0, 0.9644147]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.05)
        gradient.endPoint = CGPoint(x: 0.5, y: 0.78)
        view.layer.addSublayer(gradient)
        return view
    }()
    
    /// StackView with basic model informations
    private lazy var modelStackView: UIStackView = {
        UIStackView.make(axis: .horizontal, with: [ModelNameView(car: car), carImageView], spacing: 10.0, distribution: .fillEqually)
    }()

    /// Image view of certain car model
    private lazy var carImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = car.image
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        return imageView.layoutable()
    }()

    /// StackView with performance informations
    private lazy var performanceStackView: UIStackView = {
        let topSpeedProgressView = PartOvalProgressView(state: PartOvalProgressView.State.topSpeed(200), invalidateChartInstantly: false)
        let accelerationOvalProgressView = PartOvalProgressView(state: PartOvalProgressView.State.accelerate(9), invalidateChartInstantly: false)
        return UIStackView.make(axis: .horizontal, with: [topSpeedProgressView, accelerationOvalProgressView], spacing: 10.0, distribution: .fillEqually)
    }()

    /// StackView with mechanical informations
    private lazy var mechanicalStackView: UIStackView = {
        let engineHorizontalProgressView = HorizontalProgressChartView(state: HorizontalProgressChartView.State.engine(1999), invalidateChartInstantly: true)
        let powerHorizontalProgressView = HorizontalProgressChartView(state: HorizontalProgressChartView.State.power(150), invalidateChartInstantly: true)
        return UIStackView.make(axis: .horizontal, with: [powerHorizontalProgressView, engineHorizontalProgressView], spacing: 30.0, distribution: .fillEqually)
    }()

    /// Button which redirects to google
    internal var googleButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "button-google"), for: .normal)
        button.imageView?.contentMode = .scaleToFill
        return button.layoutable()
    }()

    /// Button which shows scan list
    internal var carListButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "button-car-list-gray"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        return button.layoutable()
    }()

    /// Button which shows scan
    internal var scanButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "button-scan-primary"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.imageView?.clipsToBounds = false
        return button.layoutable()
    }()
    
    /// Instance of top gray beam
    private let topBeamView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 6
        view.backgroundColor = UIColor(red: 0.84, green: 0.89, blue: 0.9, alpha: 1)
        return view.layoutable()
    }()

    init(car: Car) {
        self.car = car
        super.init()
    }

    /// - SeeAlso: ViewSetupable
    func setupViewHierarchy() {
        addSubview(containerView)
        [gradientView, topBeamView, modelStackView, performanceStackView, mechanicalStackView, scanButton, googleButton, carListButton].forEach(containerView.addSubview)
    }

    /// - SeeAlso: ViewSetupable
    func setupConstraints() {
        containerView.constraintToSuperviewEdges()
        
        topBeamView.constraintToSuperviewEdges(excludingAnchors: [.bottom], withInsets: .init(top: 11, left: Dimensions.topBeamHorizontalInset, bottom: 0, right: Dimensions.topBeamHorizontalInset))

        modelStackView.constraintToEdges(of: containerView, excludingAnchors: [.bottom], withInsets: .init(top: 37, left: 35, bottom: 0, right: 35))
        modelStackView.constraintToConstant(.init(width: Dimensions.stackViewWidth, height: Dimensions.stackViewHeight))

        [performanceStackView, mechanicalStackView].forEach { stackView in
            stackView.constraintToEdges(of: containerView, excludingAnchors: [.top, .bottom], withInsets: .init(top: 0, left: 35, bottom: 0, right: 35))
            stackView.constraintToConstant(.init(width: Dimensions.stackViewWidth, height: Dimensions.stackViewHeight))
        }

        [googleButton, carListButton].forEach { button in
            button.constraintToConstant(.init(width: Dimensions.regularButtonDimension, height: Dimensions.regularButtonDimension))
        }
        scanButton.constraintToConstant(.init(width: Dimensions.bigButtonDimension, height: Dimensions.bigButtonDimension))

        carListButton.constraintToEdges(of: containerView, excludingAnchors: [.top, .right], withInsets: .init(top: 0, left: 32, bottom: 16, right: 0))
        googleButton.constraintToEdges(of: containerView, excludingAnchors: [.top, .left], withInsets: .init(top: 0, left: 0, bottom: 16, right: 32))
        gradientView.constraintToConstant(.init(width: UIScreen.main.bounds.width, height: 140.0))
        gradientView.constraintToEdges(of: containerView, excludingAnchors: [.top], withInsets: .init(top: 0, left: 0, bottom: 0, right: 0))

        NSLayoutConstraint.activate([
            topBeamView.heightAnchor.constraint(equalToConstant: 3.0),
            performanceStackView.topAnchor.constraint(equalTo: modelStackView.bottomAnchor, constant: 20.0),
            mechanicalStackView.topAnchor.constraint(equalTo: performanceStackView.bottomAnchor, constant: 10.0),
            scanButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8.0),
            scanButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0)
        ])
    }
}

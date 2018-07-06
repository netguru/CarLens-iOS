//
//  CarCardView.swift
//  CarRecognition
//


import UIKit

internal final class CarCardView: View, ViewSetupable {

    /// Struct that holds informations about view's dimensions
    struct Dimensions {
        static let topBeamHorizontalInset = UIScreen.main.bounds.width * 0.4
        static let stackViewWidth = UIScreen.main.bounds.width * 0.8
        static let stackViewHeight = UIScreen.main.bounds.height / 12
        static let regularButtonDimension = 45.0
        static let bigButtonDimension = 70.0
        static let gradientHeight: CGFloat = 140.0
        static let viewHeight = UIScreen.main.bounds.height / 2
    }

    /// Car instance used to initialize subviews
    private let car: Car

    /// Gray Beam view visible at the top
    private let topBeamView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 6
        view.backgroundColor = UIColor(hex: 0xD6E3E5)
        return view.layoutable()
    }()

    /// Main container of the view
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 14.0
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        return view.layoutable()
    }()

    /// Gradient view visible at the bottom
    private lazy var gradientView: UIView = {
        let view = UIView()
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: Dimensions.gradientHeight)
        gradient.colors = [
            UIColor.white.cgColor,
            UIColor(hex: 0xEFF5F5).cgColor
        ]
        gradient.locations = [0, 0.9644147]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.05)
        gradient.endPoint = CGPoint(x: 0.5, y: 0.78)
        view.layer.addSublayer(gradient)
        return view.layoutable()
    }()

    /// StackView with basic model informations
    private lazy var modelStackView: UIStackView = .make(
        axis: .horizontal,
        with: [ModelNameView(car: car), carImageView],
        spacing: 10.0,
        distribution: .fillEqually
    )

    /// ImageView of certain car model
    private lazy var carImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = car.image.unlocked
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView.layoutable()
    }()

    /// StackView with performance informations
    private lazy var performanceStackView: UIStackView = {
        let topSpeedProgressView = PartOvalProgressView(state: PartOvalProgressView.State.topSpeed(200), invalidateChartInstantly: false)
        let accelerationOvalProgressView = PartOvalProgressView(state: PartOvalProgressView.State.accelerate(9), invalidateChartInstantly: false)
        return .make(axis: .horizontal, with: [topSpeedProgressView, accelerationOvalProgressView], spacing: 10.0, distribution: .fillEqually)
    }()

    /// StackView with mechanical informations
    private lazy var mechanicalStackView: UIStackView = {
        let engineHorizontalProgressView = HorizontalProgressChartView(state: HorizontalProgressChartView.State.engine(1999), invalidateChartInstantly: true)
        let powerHorizontalProgressView = HorizontalProgressChartView(state: HorizontalProgressChartView.State.power(150), invalidateChartInstantly: true)
        return .make(axis: .horizontal, with: [powerHorizontalProgressView, engineHorizontalProgressView], spacing: 30.0, distribution: .fillEqually)
    }()

    /// Google button in bottom right corner
    internal var googleButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "button-google"), for: .normal)
        button.imageView?.contentMode = .scaleToFill
        button.layer.shadowOpacity = 0.2
        button.layer.shadowColor = UIColor(hex: 0xFF5969).withAlphaComponent(0.4).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 10)
        return button.layoutable()
    }()

    /// Car list button visible in bottom left corner
    internal var carListButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "button-car-list-white"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.layer.shadowOpacity = 0.2
        button.layer.shadowColor = UIColor(hex: 0xFF5969).withAlphaComponent(0.4).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 10)
        return button.layoutable()
    }()

    /// Recognize button visible at the bottom
    internal var scanButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "button-scan-primary-no-shadow"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.imageView?.clipsToBounds = false
        button.layer.shadowOpacity = 0.6
        button.layer.shadowColor = UIColor(hex: 0xFF5969).withAlphaComponent(0.4).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 10)
        return button.layoutable()
    }()

    /// Initializes the card view with given car parameter
    ///
    /// - Parameter car: Car instance used to instantiate subviews
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

        gradientView.constraintToConstant(.init(width: UIScreen.main.bounds.width, height: 140.0))
        gradientView.constraintToEdges(of: containerView, excludingAnchors: [.top])

        NSLayoutConstraint.activate([
            topBeamView.heightAnchor.constraint(equalToConstant: 3.0),
            performanceStackView.topAnchor.constraint(equalTo: modelStackView.bottomAnchor, constant: 20.0),
            mechanicalStackView.topAnchor.constraint(equalTo: performanceStackView.bottomAnchor, constant: 10.0),
            scanButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8.0),
            scanButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            carListButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
            carListButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 32),
            googleButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
            googleButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -32)
        ])
    }
}

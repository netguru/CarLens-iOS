//
//  CarCardView.swift
//  CarLens
//


import UIKit
import Lottie

final class CarCardView: View, ViewSetupable {

    /// Struct that holds informations about view's dimensions and constants
    enum Constants {
        static let topBeamHorizontalInset = UIScreen.main.bounds.width * 0.4
        static let stackViewHeight: CGFloat = 65
        static let regularButtonDimension = 45.0
        static let bigButtonDimension = 70.0
        static let gradientHeight: CGFloat = 140.0
        static let mechanicalTopOffset: CGFloat = UIDevice.screenSizeBiggerThan4Point7Inches ? 20 : 30
        static let rippleInitialFrame: NSNumber = 61
        static let rippleLastFrame: NSNumber = 122
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
        gradient.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: Constants.gradientHeight)
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

    private lazy var topSpeedProgressView = PartOvalProgressView(state: .topSpeed(car.speed))

    private lazy var accelerationOvalProgressView = PartOvalProgressView(state: .accelerate(car.acceleration))

    /// StackView with performance informations
    private lazy var performanceStackView = UIStackView.make(
        axis: .horizontal,
        with: [topSpeedProgressView, accelerationOvalProgressView],
        spacing: 10.0,
        distribution: .fillEqually
    )

    private lazy var engineHorizontalProgressView = HorizontalProgressChartView(state: .engine(car.engine))

    private lazy var powerHorizontalProgressView = HorizontalProgressChartView(state: .power(car.power))
	
	private lazy var progressableViews: [ViewProgressable] = [
		topSpeedProgressView,
		accelerationOvalProgressView,
		engineHorizontalProgressView,
		powerHorizontalProgressView
	]

    /// StackView with mechanical informations
    private lazy var mechanicalStackView = UIStackView.make(
        axis: .horizontal,
        with: [powerHorizontalProgressView,
               engineHorizontalProgressView],
        spacing: 30.0,
        distribution: .fillEqually
    )

    /// Google button in bottom right corner
    var googleButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "button-google"), for: .normal)
        button.imageView?.contentMode = .scaleToFill
        button.layer.shadowOpacity = 0.2
        button.layer.shadowColor = UIColor.crShadowOrange.withAlphaComponent(0.3).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 12)
        return button.layoutable()
    }()

    /// Car list button visible in bottom left corner
    var carListButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "button-car-list-white"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.layer.shadowOpacity = 0.2
        button.layer.shadowColor = UIColor.crShadowOrange.withAlphaComponent(0.3).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 12)
        return button.layoutable()
    }()

    /// Recognize button visible at the bottom
    var scanButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "button-scan-primary"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.imageView?.clipsToBounds = false
        button.layer.shadowOpacity = 0.4
        button.layer.shadowColor = UIColor.crShadowOrange.withAlphaComponent(0.4).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 12)
        return button.layoutable()
    }()

    private lazy var rippleAnimationView: LOTAnimationView = {
        let view = LOTAnimationView(name: "button-ripple")
        view.animationSpeed = 0.8
        view.loopAnimation = true
        view.play(fromFrame: Constants.rippleInitialFrame, toFrame: Constants.rippleLastFrame)
        view.isHidden = car.isDiscovered
        return view.layoutable()
    }()

    /// Initializes the card view with given car parameter
    ///
    /// - Parameter car: Car instance used to instantiate subviews
    init(car: Car) {
        self.car = car
        super.init()
    }

    /// Hides ripple effect around car list button
    func hideRippleEffect() {
        rippleAnimationView.isHidden = true
    }

    /// Sets all charts of the view
    ///
    /// - Parameters:
    ///   - animated: Indicating if the change should be animated
    ///   - toZero: Indicating if charts should be cleared
    func setCharts(animated: Bool, toZero: Bool) {
		progressableViews.forEach { $0.setChart(animated: animated, toZero: toZero) }
    }

    /// Animates attach pin error label
    func animateAttachPinError() {
        ToastDisplayer.show(in: containerView,
                            text: Localizable.CarCard.attachPinError)
    }

    /// - SeeAlso: ViewSetupable
    func setupViewHierarchy() {
        addSubview(containerView)
        [gradientView, topBeamView, modelStackView, performanceStackView, mechanicalStackView,
         rippleAnimationView, scanButton, googleButton, carListButton].forEach(containerView.addSubview)
    }

    /// - SeeAlso: ViewSetupable
    func setupConstraints() {
        containerView.constraintToSuperviewEdges()

        topBeamView.constraintToSuperviewEdges(excludingAnchors: [.bottom],
                                               withInsets: .init(top: 11, left: Constants.topBeamHorizontalInset,
                                                                 bottom: 0, right: Constants.topBeamHorizontalInset))

        modelStackView.constraintToEdges(of: containerView,
                                         excludingAnchors: [.bottom],
                                         withInsets: .init(top: 37, left: 35, bottom: 0, right: 35))

        [performanceStackView, mechanicalStackView].forEach { stackView in
            stackView.constraintToEdges(of: containerView,
                                        excludingAnchors: [.top, .bottom],
                                        withInsets: .init(top: 0, left: 35, bottom: 0, right: 35))
        }

        [googleButton, carListButton].forEach { button in
            button.constraintToConstant(.init(width: Constants.regularButtonDimension,
                                              height: Constants.regularButtonDimension))
        }
        scanButton.constraintToConstant(.init(width: Constants.bigButtonDimension,
                                              height: Constants.bigButtonDimension))

        gradientView.constraintToConstant(.init(width: UIScreen.main.bounds.width, height: 140))
        gradientView.constraintToEdges(of: containerView, excludingAnchors: [.top])
        rippleAnimationView.constraintCenter(to: carListButton)

        NSLayoutConstraint.activate([
            topBeamView.heightAnchor.constraint(equalToConstant: 3),
            performanceStackView.topAnchor.constraint(equalTo: modelStackView.bottomAnchor, constant: 20),
            mechanicalStackView.topAnchor.constraint(equalTo: performanceStackView.bottomAnchor,
                                                     constant: Constants.mechanicalTopOffset),
            scanButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8),
            scanButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            carListButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            carListButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 32),
            googleButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            googleButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -32),
            performanceStackView.heightAnchor.constraint(equalToConstant: Constants.stackViewHeight + 30),
            mechanicalStackView.heightAnchor.constraint(equalToConstant: Constants.stackViewHeight - 20),
            modelStackView.heightAnchor.constraint(equalToConstant: Constants.stackViewHeight + 2)
        ])
    }
}

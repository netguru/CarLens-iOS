//
//  CarListCollectionViewCell.swift
//  CarLens
//


import UIKit.UICollectionView

final class CarListCollectionViewCell: UICollectionViewCell, ViewSetupable {

    /// Indicates if the cell is currently displayed as primary cell
    private var isCurrentlyPrimary = false

    private let topViewHeight: CGFloat = UIDevice.screenSizeBiggerThan4Inches ? 200 : 170

    private lazy var topView = LabeledCarImageView().layoutable()

    private lazy var cardView: CarListCardView = {
        let view = CarListCardView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view.layoutable()
    }()

    /// - SeeAlso: UICollectionViewCell.init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    /// - SeeAlso: UICollectionViewCell.init
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Setups the cell with given car
    ///
    /// - Parameter car: Car to be used for updating the cell
    func setup(with car: Car) {
        topView.setup(with: car)
        cardView.setup(with: car)
    }

    /// Sets values for charts in the cell. Animates setting
    func setChartsValues() {
        let animated = isCurrentlyPrimary
        let toZero = !isCurrentlyPrimary

        cardView.setCharts(animated: animated, toZero: toZero)
    }

    private func animateViews(toProgress progress: Double) {
        let offset = topViewHeight - (CGFloat(progress) * topViewHeight)
        cardView.transform = .init(translationX: 0, y: -offset)
    }

    /// - SeeAlso: ViewSetupable
    func setupViewHierarchy() {
        [topView, cardView].forEach(contentView.addSubview)
    }

    /// - SeeAlso: ViewSetupable
    func setupConstraints() {
        topView.constraintToSuperviewEdges(excludingAnchors: [.bottom])
        cardView.constraintToSuperviewEdges(excludingAnchors: [.top])
        NSLayoutConstraint.activate([
            topView.heightAnchor.constraint(equalToConstant: topViewHeight),
            cardView.topAnchor.constraint(equalTo: topView.bottomAnchor)
        ])
    }

    /// - SeeAlso: UICollectionViewCell
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        guard let attributes = layoutAttributes as? CarListLayoutAttributes else { return }
        isCurrentlyPrimary = !(attributes.progress == 0)
        animateViews(toProgress: attributes.progress)
    }

    /// - SeeAlso: UICollectionViewCell
    override func prepareForReuse() {
        super.prepareForReuse()
        cardView.setCharts(animated: false, toZero: true)
    }
}

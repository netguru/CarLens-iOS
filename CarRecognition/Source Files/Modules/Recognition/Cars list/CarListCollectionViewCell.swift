//
//  CarListCollectionViewCell.swift
//  CarRecognition
//


import UIKit.UICollectionView

internal final class CarListCollectionViewCell: UICollectionViewCell, ViewSetupable {
    
    private let topViewHeight: CGFloat = 200
    
    private lazy var topView = LabeledCarImageView().layoutable()
    
    private lazy var cardView: UIView = {
        let view = CarListCardView(car: .known(make: .volkswagen, model: "passat"))
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
        animateViews(toProgress: attributes.progress)
    }
}

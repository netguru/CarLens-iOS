//
//  CarListCollectionViewCell.swift
//  CarRecognition
//


import UIKit.UICollectionView

internal final class CarListCollectionViewCell: UICollectionViewCell, ViewSetupable {
    
    private let topViewHeight: CGFloat = 200
    
    private lazy var topView = UIView().layoutable()
    
    private lazy var carImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view.layoutable()
    }()
    
    private lazy var cardView: UIView = {
        let view = UIView()
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
    
    private func animateViews(toProgress progress: Double) {
        let offset = topViewHeight - (CGFloat(progress) * topViewHeight)
        cardView.transform = .init(translationX: 0, y: -offset)
    }
    
    /// - SeeAlso: ViewSetupable
    func setupViewHierarchy() {
        [topView, cardView].forEach(contentView.addSubview)
        topView.addSubview(carImageView)
    }
    
    /// - SeeAlso: ViewSetupable
    func setupConstraints() {
        topView.constraintToSuperviewEdges(excludingAnchors: [.bottom])
        cardView.constraintToSuperviewEdges(excludingAnchors: [.top])
        carImageView.constraintCenterToSuperview()
        carImageView.constraintToConstant(.init(width: 240, height: 180))
        NSLayoutConstraint.activate([
            topView.heightAnchor.constraint(equalToConstant: topViewHeight),
            cardView.topAnchor.constraint(equalTo: topView.bottomAnchor)
        ])
    }
    
    /// - SeeAlso: ViewSetupable
    func setupProperties() {
        carImageView.image = #imageLiteral(resourceName: "VolkswagenPassat_locked")
    }
    
    /// - SeeAlso: UICollectionViewCell
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        guard let attributes = layoutAttributes as? CarListLayoutAttributes else { return }
        animateViews(toProgress: attributes.progress)
    }
}

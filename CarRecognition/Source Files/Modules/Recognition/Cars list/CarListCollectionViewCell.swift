//
//  CarListCollectionViewCell.swift
//  CarRecognition
//


import UIKit.UICollectionView

internal final class CarListCollectionViewCell: UICollectionViewCell, ViewSetupable {
    
    private lazy var topView = UIView().layoutable()
    
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
        print("animate to progress: \(progress)")
        let offset = topView.bounds.height - (CGFloat(progress) * topView.bounds.height)
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
            cardView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            topView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    /// - SeeAlso: ViewSetupable
    func setupProperties() {
        topView.backgroundColor = .purple
    }
    
    /// - SeeAlso: UICollectionViewCell
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        guard let attributes = layoutAttributes as? CarListLayoutAttributes else { return }
        animateViews(toProgress: attributes.progress)
    }
}

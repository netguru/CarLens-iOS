//
//  CarListCollectionViewCell.swift
//  CarRecognition
//


import UIKit.UICollectionView

internal final class CarListCollectionViewCell: UICollectionViewCell, ViewSetupable {
    
    private lazy var topView = UIView().layoutable()
    
    private lazy var cardView = UIView().layoutable()
    
    /// - SeeAlso: UICollectionViewCell.init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    /// - SeeAlso: UICollectionViewCell.init
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            cardView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    /// - SeeAlso: ViewSetupable
    func setupProperties() {
        backgroundColor = .blue
        topView.backgroundColor = .purple
        cardView.backgroundColor = .yellow
    }
}

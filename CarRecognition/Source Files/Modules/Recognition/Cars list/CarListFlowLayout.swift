//
//  CarListFlowLayout.swift
//  CarRecognition
//


import UIKit

internal final class CarListFlowLayout: UICollectionViewFlowLayout {
    
    private var firstSetupDone = false
    
    private let spacingBetweenElements = 20
    
    override func prepare() {
        super.prepare()
        if !firstSetupDone {
            setup()
            firstSetupDone = true
        }
    }
    
    private func setup() {
        guard let collectionView = collectionView else { return }
        scrollDirection = .horizontal
        minimumLineSpacing = 20
        itemSize = CGSize(width: collectionView.bounds.width - 80, height: collectionView.bounds.height)
        let inset = (collectionView.bounds.width - itemSize.width) / 2
        collectionView.contentInset = .init(top: 0, left: inset, bottom: 0, right: inset)
        collectionView.decelerationRate = UIScrollViewDecelerationRateFast
    }
    
    /// SeeAlso: UICollectionViewFlowLayout
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView, let layoutAttributes = layoutAttributesForElements(in: collectionView.bounds) else {
            return .init(x: 0, y: 0)
        }
        
        // Snapping closest cell to the center
        let centerOffset = collectionView.bounds.size.width / 2
        let offsetWithCenter = proposedContentOffset.x + centerOffset
        let closestAttribute = layoutAttributes
            .sorted { abs($0.center.x - offsetWithCenter) < abs($1.center.x - offsetWithCenter) }
            .first ?? UICollectionViewLayoutAttributes()
        return CGPoint(x: closestAttribute.center.x - centerOffset, y: 0)
    }
}

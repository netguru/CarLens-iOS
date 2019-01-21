//
//  UICollectionViewExtension.swift
//  CarLens
//


import UIKit.UICollectionView

internal extension UICollectionView {
    
    /// - SeeAlso: UICollectionView.register
    func register<T: UICollectionViewCell>(cell: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.className)
    }
    
    /// - SeeAlso: UICollectionView.dequeueReusableCell
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withReuseIdentifier: T.className, for: indexPath) as? T
    }
}

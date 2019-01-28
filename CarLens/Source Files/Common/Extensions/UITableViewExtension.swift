//
//  UITableViewExtension.swift
//  CarLens
//


import UIKit.UITableView

extension UITableView {

    /// - SeeAlso: UITableView.register
    func register<T: UITableViewCell>(cell: T.Type) {
        register(T.self, forCellReuseIdentifier: T.className)
    }

    /// - SeeAlso: UITableView.dequeueReusableCell
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: T.className, for: indexPath) as? T
    }

    /// - SeeAlso: UITableView.dequeueReusableHeaderFooter
    func dequeueReusableHeaderFooter<T: UIView>() -> T? {
        return dequeueReusableHeaderFooterView(withIdentifier: T.className) as? T
    }

    /// Workaround for not working AutoLayout with UITableView.tableHeaderView
    /// This function needs to be called after calculating TableView position
    /// In case of UIViewController: viewDidLayoutSubviews()
    /// In case of UIView: layoutSubviews()
    func relayoutTableHeaderView() {
        guard let tableHeaderView = tableHeaderView else { return }
        tableHeaderView.layoutIfNeeded()
        tableHeaderView.frame.size = tableHeaderView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        self.tableHeaderView = tableHeaderView
    }
}

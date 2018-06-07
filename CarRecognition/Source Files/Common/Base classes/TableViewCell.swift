//
//  TableViewCell.swift
//  CarRecognition
//


import UIKit

/// Base class reducing boilerplate inside UITableViewCell subclasses
internal class TableViewCell: UITableViewCell {

    /// - SeeAlso: UITableViewCell
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        (self as? ViewSetupable)?.setupView()
    }
    
    /// - SeeAlso: UITableViewCell
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

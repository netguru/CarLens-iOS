//
//  CarTypeSearchView.swift
//  CarRecognition
//


import UIKit

internal final class CarTypeSearchView: View, ViewSetupable {
    
    /// Label with analyzed car model
    lazy var modelLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 26)
        view.numberOfLines = 2
        view.textAlignment = .center
        return view
    }()
    
    /// Image view ith image used for analyze
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    /// TableView with found car models
    lazy var tableView: UITableView = {
        let view = UITableView()
        return view.layoutable()
    }()
    
    private lazy var stackView = UIStackView.make(
        axis: .vertical,
        with: [
            modelLabel,
            imageView,
            tableView,
        ],
        spacing: 5
        ).layoutable()
    
    /// - SeeAlso: ViewSetupable
    func setupViewHierarchy() {
        addSubview(stackView)
    }
    
    /// - SeeAlso: ViewSetupable
    func setupConstraints() {
        stackView.constraintToSuperviewLayoutGuide()
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: widthAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    /// - SeeAlso: ViewSetupable
    func setupProperties() {
        backgroundColor = .white
    }
}

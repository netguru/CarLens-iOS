//
//  ViewSetupable.swift
//  CarLens
//


/// Interface for setting up the view
internal protocol ViewSetupable {

    /// Add subviews to the view when called
    func setupViewHierarchy()

    /// Add constraints to the view when called
    func setupConstraints()

    /// Setup required properties when called
    func setupProperties()
}

internal extension ViewSetupable {

    // Empty default implementation - not every class need this method
    func setupProperties() { }

    /// Calls all other setup methods in proper order
    func setupView() {
        setupViewHierarchy()
        setupConstraints()
        setupProperties()
    }
}

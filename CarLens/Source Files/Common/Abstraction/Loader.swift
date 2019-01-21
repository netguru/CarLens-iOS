//
//  Loader.swift
//  CarLens
//


/// Interface for displaying loader covering the view
internal protocol Loader {
    
    /// Indicating if loader is currently spinning
    var isSpinning: Bool { get }
    
    /// Changes state of the loader
    ///
    /// - Parameters:
    ///   - show: Indicating if loader shold be shown or hidden
    func toggle(_ show: Bool)
}

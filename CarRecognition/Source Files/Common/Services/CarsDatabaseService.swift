//
//  CarsDatabaseService.swift
//  CarRecognition
//


import Foundation

internal final class CarsDatabaseService {
    
    private let userDefault = UserDefaults()
    
    /// Maps car `isDiscovered` parameter to proper value
    ///
    /// - Parameter car: Car to be mapped
    func mapDiscoveredParameter(car: inout Car) {
        car.isDiscovered = isAlreadyAddedAsRecognized(car: car)
    }
    
    /// Maps cars `isDiscovered` parameter to proper value
    ///
    /// - Parameter cars: Cars to be mapped
    func mapDiscoveredParameter(for cars: inout [Car]) {
        for index in 0..<cars.count {
            mapDiscoveredParameter(car: &cars[index])
        }
    }
    
    /// Marks given car as discovered or not
    ///
    /// - Parameters:
    ///   - car: Car to be set
    ///   - discovered: Inticating if car was discovered or not
    func mark(car: Car, asDiscovered discovered: Bool) {
        if discovered {
            addToTheRecognizedCars(car: car)
        } else {
            removeFromTheRecognizedCars(car: car)
        }
    }
}

private extension CarsDatabaseService {
    
    private func addToTheRecognizedCars(car: Car) {
        userDefault.set(true, forKey: car.id)
    }
    
    private func removeFromTheRecognizedCars(car: Car) {
        userDefault.removeObject(forKey: car.id)
    }
    
    private func isAlreadyAddedAsRecognized(car: Car) -> Bool {
        return userDefault.bool(forKey: car.id)
    }
}

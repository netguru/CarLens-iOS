//
//  CarsDatabaseService.swift
//  CarLens
//


import Foundation

internal final class CarsDatabaseService {
    
    private let userDefaults: UserDefaults
    
    /// Initializes the Cars Database Service.
    ///
    /// - Parameter userDefaults: User Defaults used to save the data.
    init(with userDefaults: UserDefaults = UserDefaults()) {
        self.userDefaults = userDefaults
    }
    
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
    ///   - discovered: Indicating if car was discovered or not
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
        userDefaults.set(true, forKey: car.id)
    }
    
    private func removeFromTheRecognizedCars(car: Car) {
        userDefaults.removeObject(forKey: car.id)
    }
    
    private func isAlreadyAddedAsRecognized(car: Car) -> Bool {
        return userDefaults.bool(forKey: car.id)
    }
}

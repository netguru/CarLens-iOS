//
//  CarsDatabaseService.swift
//  CarRecognition
//


internal final class CarsDatabaseService {
    
    /// Maps car `isDiscovered` parameter to proper value
    ///
    /// - Parameter car: Car to be mapped
    func mapDiscoveredParameter(car: inout Car) {
        // TODO: Replace with real database checking
        car.isDiscovered = false
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
    func mark(car: Car, asDiscovered disceovered: Bool) {
        // TODO: Replace with saving it to the database
    }
}

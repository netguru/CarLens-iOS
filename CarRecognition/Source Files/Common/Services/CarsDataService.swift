//
//  CarsDataService.swift
//  CarRecognition
//


internal final class CarsDataService {
    
    private let localDataService = LocalCarsDataService()
    
    private let databaseService = CarsDatabaseService()
    
    /// Maps label received from classifier to car object
    ///
    /// - Parameter classifierLabel: Label received from classifier
    /// - Returns: Mapped object
    func map(classifierLabel: String) -> Car? {
        guard var car = localDataService.cars.first(where: { $0.id == classifierLabel }) else { return nil }
        databaseService.mapDiscoveredParameter(car: &car)
        return car
    }
    
    /// Gets all available cars with proper recognized states
    ///
    /// - Returns: Fetched cars
    func getAvailableCars() -> [Car] {
        var cars = localDataService.cars
        databaseService.mapDiscoveredParameter(for: &cars)
        return cars
    }
    
    /// Gets number of available cars
    ///
    /// - Returns: Fetched cars
    func getNumberOfCars() -> Int {
        return localDataService.cars.count
    }
    
    /// Gets number of discovered cars
    ///
    /// - Returns: Fetched cars
    func getNumberOfDiscoveredCars() -> Int {
        let discoveredCars = getAvailableCars().filter { $0.isDiscovered }
        return discoveredCars.count
    }
    
    /// Marks given car as discovered or not
    ///
    /// - Parameters:
    ///   - car: Car to be set
    ///   - discovered: Indicating if the car was discovered or not
    func mark(car: Car, asDiscovered discovered: Bool) {
        databaseService.mark(car: car, asDiscovered: discovered)
    }
}

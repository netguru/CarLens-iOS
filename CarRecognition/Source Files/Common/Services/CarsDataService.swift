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
        // TODO: Temporary, to be removed after machine learning model change
        let mappedClassifierLabel = mapToCorrectClassifierLabel(classifierLabel: classifierLabel)
        
        guard var car = localDataService.cars.first(where: { $0.id == mappedClassifierLabel }) else { return nil }
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
    
    /// Checks if given car was already recognized
    ///
    /// - Parameter car: Car to be checked
    /// - Returns: Value indicating if car was recognized before
    func isAlreadyRecognized(car: Car) -> Bool {
        return databaseService.isAlreadyRecognized(car: car)
    }
    
    // TODO: Temporary function, to be removed after machine learning model change
    private func mapToCorrectClassifierLabel(classifierLabel: String) -> String {
        switch classifierLabel {
        case "toyota camry":
            return "ToyotaCamry"
        case "honda civic":
            return "HondaCivic"
        case "toyota corolla":
            return "ToyotaCorolla"
        case "ford fiesta":
            return "FordFiesta"
        case "volkswagen golf":
            return "VolkswagenGolf"
        case "nissan qashqai":
            return "NissanQashqai"
        case "volkswagen passat":
            return "VolkswagenPassat"
        case "volkswagen tiguan":
            return "VolkswagenTiguan"
        default:
            return classifierLabel
        }
    }
}


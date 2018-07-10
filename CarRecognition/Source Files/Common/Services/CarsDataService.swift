//
//  CarsDataService.swift
//  CarRecognition
//


internal final class CarsDataService {
    
    private let localDataService = LocalCarsDataService()
    
    private let databaseService = CarsDatabaseService()
    
    func map(classifierLabel: String) -> Car? {
        let mappedClassifierLabel = mapToCorrectClassifierLabel(classifierLabel: classifierLabel)
        
        guard var car = localDataService.cars.first(where: { $0.id == mappedClassifierLabel }) else { return nil }
        car.discovered = databaseService.isAlreadyDiscovered(car: car)
        return car
    }
    
    private func mapToCorrectClassifierLabel(classifierLabel: String) -> String {
        switch classifierLabel {
        case "toyota camry":
            return "ToyotaCamry"
        default:
            return classifierLabel
        }
    }
}


//
//  CarsDataService.swift
//  CarRecognition
//


internal final class CarsDataService {
    
    private let localDataService = LocalCarsDataService()
    
    private let databaseService = CarsDatabaseService()
    
    func map(classifierLabel: String) -> Car? {
        // TODO: Temporary, to be removed after model change
        let mappedClassifierLabel = mapToCorrectClassifierLabel(classifierLabel: classifierLabel)
        
        guard var car = localDataService.cars.first(where: { $0.id == mappedClassifierLabel }) else { return nil }
        car.discovered = databaseService.isAlreadyDiscovered(car: car)
        return car
    }
    
    // TODO: Temporary function, to ve removed after model change
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


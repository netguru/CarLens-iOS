//
//  LocalCarsDataService.swift
//  CarRecognition
//


internal final class LocalCarsDataService {
    
    /// Array of local car objects
    var cars: [Car] = []
    
    /// Initializes the service feeding `localCars` parameter with fetched data
    init() {
        guard
            let jsonPath = Bundle.main.path(forResource: "cars", ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: jsonPath)),
            let decoded = try? JSONDecoder().decode(LocalCars.self, from: data)
        else {
            return
        }
        cars = decoded.cars
    }
}

private struct LocalCars: Decodable {
    let cars: [Car]
}

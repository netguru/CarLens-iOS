//
//  LocalCarsDataService.swift
//  CarLens
//


internal final class LocalCarsDataService {
    
    /// Array of local car objects
    var cars: [Car] = []
    
    /// Initializes the service feeding `localCars` parameter with fetched data
    init(with jsonPath: String? = Bundle.main.path(forResource: "cars", ofType: "json")) {
        guard
            let path = jsonPath,
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
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

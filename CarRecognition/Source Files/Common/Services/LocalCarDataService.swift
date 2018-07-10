//
//  LocalCarDataService.swift
//  CarRecognition
//


internal final class LocalCarDataService {
    
    /// Array of local car objects
    var localCars: [LocalCarData] = []
    
    /// Initializes the service feeding `localCars` parameter with fetched data
    init() {
        guard
            let jsonPath = Bundle.main.path(forResource: "cars", ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: jsonPath)),
            let decoded = try? JSONDecoder().decode(LocalCars.self, from: data)
        else {
            localCars =  []
            return
        }
        localCars = decoded.cars
    }
}

struct LocalCars: Decodable {
    let cars: [LocalCarData]
}

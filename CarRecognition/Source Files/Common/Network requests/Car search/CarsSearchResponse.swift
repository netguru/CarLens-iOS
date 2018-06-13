//
//  CarSearchResponse.swift
//  CarRecognition
//


internal struct CarsSearchResponse: NetworkResponse {
    
    let cars: [Car]
    
    enum CodingKeys: String, CodingKey {
        case cars = "Trims"
    }
}

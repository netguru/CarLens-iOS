//
//  CarSearchResponse.swift
//  CarRecognition
//


internal struct CarsSearchResponse: NetworkResponse {
    
    let cars: [APICar]
    
    enum CodingKeys: String, CodingKey {
        case cars = "Trims"
    }
}

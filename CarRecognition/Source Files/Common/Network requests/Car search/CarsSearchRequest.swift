//
//  CarsSearchRequest.swift
//  CarRecognition
//


internal struct CarsSearchRequest: NetworkRequest {
    typealias Response = CarsSearchResponse
    
    let keyword: String
    
    /// - SeeAlso: APIRequest.method
    var method: NetworkMethod {
        return .GET
    }
    
    /// - SeeAlso: APIRequest.path
    var path: String {
        return "/"
    }
    
    /// - SeeAlso: urlQueryItems
    var urlQueryItems: [URLQueryItem]? {
        return [
            URLQueryItem(name: "callback", value: "?"),
            URLQueryItem(name: "cmd", value: "getTrims"),
            URLQueryItem(name: "keyword", value: keyword)
        ]
    }
}

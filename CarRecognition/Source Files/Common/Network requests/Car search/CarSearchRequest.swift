//
//  CarSearchRequest.swift
//  CarRecognition
//


internal struct CarSearchRequest: NetworkRequest {
    typealias Response = CarSearchResponse
    
    let keyword: String
    
    /// - SeeAlso: APIRequest.method
    var method: NetworkMethod {
        return .GET
    }
    
    /// - SeeAlso: APIRequest.path
    var path: String {
        return "/?callback=?&cmd=getTrims&keyword=\(keyword)"
    }
}

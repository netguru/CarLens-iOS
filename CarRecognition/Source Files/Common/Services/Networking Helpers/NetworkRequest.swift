//
//  NetworkRequest.swift
//  CarRecognition
//


import Foundation

/// Request method
internal enum NetworkMethod: String {
    case GET, POST, PUT, DELETE
}

/// Contains all needed infomations to make request
internal protocol NetworkRequest: Encodable {
    
    /// Type of the response
    associatedtype Response: Decodable
    
    /// HTTP method for request
    var method: NetworkMethod { get }
    
    /// Path to the resource
    var path: String { get }
    
    /// Indicates version of API that should be used for given request
    var version: String { get }
    
    /// Indicates Network service that should be used
    var networkApplication: NetworkApplication { get }
    
    /// Encoded data of the request
    var encodedHTTPBody: Data? { get }
    
    /// Query items of the request
    var urlQueryItems: [URLQueryItem]? { get }
}

/// Default values for any api request
internal extension NetworkRequest {
    
    var version: String { return "/0.3" }
    
    var networkApplication: NetworkApplication { return CarQueryNetworkApplication() }
    
    var encodedHTTPBody: Data? {
        let encoder = JSONEncoder()
        return try? encoder.encode(self)
    }
    
    var urlQueryItems: [URLQueryItem]? { return nil }
    
    /// - SeeAlso: Swift.Encodable
    /// Has default implementation because not every request has http body
    /// Override if want to use http body with request
    func encode(to encoder: Encoder) throws { }
}

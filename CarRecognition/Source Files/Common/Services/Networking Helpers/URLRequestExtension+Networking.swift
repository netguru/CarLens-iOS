//
//  URLRequestExtension+Networking.swift
//  CarRecognition
//


import Foundation

internal extension URLRequest {
    
    /// Convenience initializer for NetworkRequest
    ///
    /// - Parameter request: type conforming to NetworkRequest
    init<Request>(request: Request) where Request: NetworkRequest {
        
        // Build the URL
        var urlComponents = URLComponents()
        urlComponents.scheme = request.networkApplication.scheme.rawValue
        urlComponents.host = request.networkApplication.host
        urlComponents.path = request.networkApplication.root + request.version + request.path
        
        // Set request query parameters for GET method
        if request.method == .GET {
            urlComponents.queryItems = request.urlQueryItems
        }
        
        guard let url = urlComponents.url else {
            fatalError("Error while parsing url components to URL object")
        }
        self.init(url: url)
        
        // Set the HTTP method
        httpMethod = request.method.rawValue
        
        // Build default headers
        let headers = [
            "Accept": "application/json",
            "Content-Type": "application/json; charset=utf-8"
        ]
        
        // Set built headers
        allHTTPHeaderFields = headers
        
        // Set encoded request body for non GET methods
        if request.method != .GET {
            httpBody = request.encodedHTTPBody
        }
    }
}

//
//  NetworkService.swift
//  CarRecognition
//


import Foundation

/// Service for performing network requests
internal protocol NetworkService {
    
    /// Performs network request and returns Observable of its reponse
    ///
    /// - Parameters:
    ///   - request: Request to be performed
    ///   - responseHandler: Response handler with type Request.Response
    func perform<Request>(request: Request, responseHandler: @escaping (NetworkResponseResult<Request.Response>) -> ()) where Request: NetworkRequest
    
    /// Handles response from the server
    ///
    /// - Parameters:
    ///   - dataTaskResponse: Response received from the URLSessionDataTask
    ///   - request: Request used to retrieve the data
    ///   - responseHandler: Response handler with type Request.Response
    func handle<Request>(dataTaskResponse: URLSessionDataTaskResponse, for request: Request, responseHandler: (NetworkResponseResult<Request.Response>) -> ()) where Request: NetworkRequest
}

/// Default network application for performing API requests
internal final class DefaultNetworkService: NetworkService {
    
    private let session: URLSession
    
    private let acceptableStatusCodes = 200 ..< 300
    
    private let authorizationErrorStatusCode = 401
    
    /// Initialize network service with given session (leave empty for shared session)
    ///
    /// - Parameter session: Session to be used for requests
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    /// - SeeAlso: NetworkService.perform(request:)
    func perform<Request>(request: Request, responseHandler: @escaping (NetworkResponseResult<Request.Response>) -> ()) where Request: NetworkRequest {
        let urlRequest = URLRequest(request: request)
        let task = self.session.dataTask(with: urlRequest) { [weak self] data, response, error in
            
            
            // carQuery API uses wrong JSON format - it needs fixing before parsing.
            var normalizedData = data
            if let data = data, let responseString = String(data: data, encoding: .utf8) {
                var normalizedString = responseString
                normalizedString = String(normalizedString.dropFirst(2))
                normalizedString = String(normalizedString.dropLast(2))
                normalizedData = normalizedString.data(using: .utf8)
            }
            
            
            let wrappedResponse = HTTPURLResponseWrapper(response: response)
            let response = URLSessionDataTaskResponse(data: normalizedData, response: wrappedResponse, error: error)
            self?.handle(dataTaskResponse: response, for: request, responseHandler: responseHandler)
        }
        task.resume()
    }
    
    /// - SeeAlso: NetworkService.handle(dataTaskResponse:for:observer:)
    func handle<Request>(dataTaskResponse: URLSessionDataTaskResponse, for request: Request, responseHandler: (NetworkResponseResult<Request.Response>) -> ()) where Request: NetworkRequest {
        // If error occurred, resolve failure immediately
        if let error = dataTaskResponse.error {
            responseHandler(.failure(.connectionError(error)))
        }
        
        // If the response is invalid, resolve failure immediately
        guard let response = dataTaskResponse.response else {
            responseHandler(.failure(.missingResponse))
            return
        }
        
        // If data is missing, resolve failure immediately
        guard let data = dataTaskResponse.data else {
            responseHandler(.failure(.missingData))
            return
        }
        
        // Initialize decoder with proper decoding strategy
        let decoder = JSONDecoder()
        
        // Validate against acceptable status codes
        guard acceptableStatusCodes ~= response.statusCode else {
            
            // Call unauthorized callback in case of unauthorized status code
            guard response.statusCode != authorizationErrorStatusCode else {
                responseHandler(.failure(.unauthorized))
                return
            }
            
            // Resolve failure with status code
            responseHandler(.failure(.unacceptableStatusCode(response.statusCode)))
            return
        }
        
        // Parse a response
        do {
            let parsedResponse = try decoder.decode(Request.Response.self, from: data)
            
            // Resolve success with a parsed response
            responseHandler(.success(parsedResponse))
        } catch let error {
            #if ENV_DEVELOPMENT
                // Prints which value failed decoding - only for development
                print("Decodable error: \(error)")
            #endif
            responseHandler(.failure(.responseParseError(error)))
        }
    }
}

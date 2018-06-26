//
//  URLSessionDataTaskResponse.swift
//  CarRecognition
//


/// Wrapper for default response of URLSessionDataTask
internal struct URLSessionDataTaskResponse {
    let data: Data?
    let response: HTTPURLResponseWrapper?
    let error: Error?
}

/// Defines response with only status code as a body
internal struct HTTPURLResponseWrapper {
    let statusCode: Int
    
    init?(statusCode: Int) {
        self.statusCode = statusCode
    }
    
    init?(response: URLResponse?) {
        guard let response = response as? HTTPURLResponse else { return nil }
        self.statusCode = response.statusCode
    }
}

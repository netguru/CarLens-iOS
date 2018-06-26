//
//  NetworkResponse.swift
//  CarRecognition
//


import Foundation

internal enum NetworkResponseResult<NetworkResponse> {
    case success(NetworkResponse)
    case failure(NetworkError)
}

/// An network response representation that has to be just decodable
internal protocol NetworkResponse: Decodable { }

/// Common empty response
internal struct EmptyResponse: NetworkResponse { }

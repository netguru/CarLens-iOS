//
//  NetworkApplication.swift
//  CarRecognition
//


import Foundation

/// Defines scheme to be used for the network application
internal enum NetworkScheme: String {
    case HTTP = "http"
    case HTTPS = "https"
}

/// Defines interface for basic network application
internal protocol NetworkApplication {
    
    /// The scheme subcomponent of the URL.
    var scheme: NetworkScheme { get }
    
    /// The host subcomponent.
    var host: String { get }
    
    /// The root subcomponent.
    var root: String { get }
}

/// Staging Service
internal struct CarQueryNetworkApplication: NetworkApplication {
    let scheme: NetworkScheme = .HTTPS
    let host: String = "www.carqueryapi.com"
    let root: String = "/api"
}

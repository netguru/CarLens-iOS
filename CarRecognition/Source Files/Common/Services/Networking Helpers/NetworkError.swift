//
//  NetworkError.swift
//  CarRecognition
//

/// Contains errors that can be thrown by `NetworkService`.
internal enum NetworkError: Error {
    
    case connectionError(Error)
    case responseParseError(Error)
    case unacceptableStatusCode(Int)
    case missingResponse
    case missingData
    case unauthorized
    
    /// - SeeAlso: Error.description
    internal var description: String {
        #if ENV_DEVELOPMENT || ENV_STAGING
            switch self {
            case .connectionError(let error):
                return "Connection failure: \(error.localizedDescription)"
            case .responseParseError(let error):
                return "Failed to parse URL response: \(error.localizedDescription)"
            case .unacceptableStatusCode(let actual):
                return "Unacceptable status code: \(actual)"
            case .missingResponse, .missingData:
                return "Missing data"
            case .unauthorized:
                return "Unauthorized"
            }
        #else
            switch self {
            default:
                return Localizable.Error.unknownErrorOccurred
            }
        #endif
    }
}

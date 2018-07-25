//
//  SearchService.swift
//  CarRecognition
//


import UIKit.UIApplication

internal final class SearchService {
    
    /// Services available to search with added base URLs as rawValue
    enum Service: String {
        case google = "https://www.google.com/search?q="
    }
    
    /// Service used for opening an URL
    private var urlOpenerService: URLOpenerService
    
    /// Initializes the Search Service
    ///
    /// - Parameter urlOpenerService: service to be used for URL opening.
    init(with urlOpenerService: URLOpenerService = URLOpenerService()) {
        self.urlOpenerService = urlOpenerService
    }
    
    /// Opens search in given service for given car
    ///
    /// - Parameters:
    ///   - service: Service to be searched
    ///   - car: Car to be used for constructing query
    ///   - completion: Completion to be called when URL will open.
    func search(_ service: Service, for car: Car, completion: ((Bool) -> Void)? = nil) {
        let phrase = "\(car.make) \(car.model)"
        let encoded = phrase.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        guard let url = URL(string: service.rawValue + encoded) else { return }
        urlOpenerService.open(url, completionHandler: completion)
    }
}

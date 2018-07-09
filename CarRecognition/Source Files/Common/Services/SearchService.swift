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
    
    /// Opens search in given service for given car
    ///
    /// - Parameters:
    ///   - service: Service to be searched
    ///   - car: Car to be used for constructing query
    func search(_ service: Service, for car: Car) {
        let phrase = "\(car.make) \(car.model)"
        guard let url = URL(string: service.rawValue + phrase), UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
}

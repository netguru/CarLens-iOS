//
//  URLOpenerService.swift
//  CarLens
//


import Foundation
import UIKit

// Interface for opening an URL
protocol URLOpener {

    /// - SeeAlso: UIApplication
    func canOpenURL(_ url: URL) -> Bool

    /// - SeeAlso: UIApplication
    func open(_ url: URL,
              options: [UIApplication.OpenExternalURLOptionsKey: Any],
              completionHandler completion: ((Bool) -> Void)?)
}

/// Struct used for opening an URL.
struct URLOpenerService {

    /// Application used to open URL.
    private let application: URLOpener

    /// Initializing the URL Opener Service
    /// - Parameter application: Application used to open URL. Default set to UIApplication.shared.
    init(with application: URLOpener = UIApplication.shared) {
        self.application = application
    }

    /// - SeeAlso: UIApplication
    func open(_ url: URL,
              options: [UIApplication.OpenExternalURLOptionsKey: Any] = [:],
              completionHandler completion: ((Bool) -> Void)? = nil) {
        if application.canOpenURL(url) {
            application.open(url, options: options, completionHandler: completion)
        } else {
            completion?(false)
        }
    }
}

//
//  UIApplicationMock.swift
//  CarLensTests
//

@testable import CarLens
import UIKit

final class UIApplicationMock: URLOpener {

    var urlString: String

    var canOpen: Bool = true

    func canOpenURL(_ url: URL) -> Bool {
        return canOpen
    }

    func open(_ url: URL,
              options: [UIApplication.OpenExternalURLOptionsKey: Any] = [:],
              completionHandler completion: ((Bool) -> Void)? = nil) {
        if canOpen {
            self.urlString = url.absoluteString
            completion?(true)
        }
    }
}

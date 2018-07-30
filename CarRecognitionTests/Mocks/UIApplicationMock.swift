//
//  UIApplicationMock.swift
//  CarRecognitionTests
//


@testable import CarRecognition
import UIKit

final class UIApplicationMock: URLOpener {
    var urlString: String? = nil
    
    var canOpen: Bool = true
    
    func canOpenURL(_ url: URL) -> Bool {
        return canOpen
    }
    
    func open(_ url: URL, options: [String : Any] = [:], completionHandler completion: ((Bool) -> Void)? = nil) {
        if canOpen {
            self.urlString = url.absoluteString
            completion?(true)
        }
    }
}

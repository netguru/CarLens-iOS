//
//  UIApplicationMock.swift
//  CarRecognitionTests
//


@testable import CarRecognition
import UIKit

struct UIApplicationMock: URLOpener {
    
    var canOpen: Bool = true
    
    func canOpenURL(_ url: URL) -> Bool {
        return canOpen
    }
    
    func open(_ url: URL, options: [String : Any] = [:], completionHandler completion: ((Bool) -> Void)? = nil) {
        if canOpen {
            completion?(true)
        }
    }
}

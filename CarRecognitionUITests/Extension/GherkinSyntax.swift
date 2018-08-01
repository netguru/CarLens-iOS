//
//  GherkinSyntax.swift
//  CarRecognitionUITests
//

import XCTest

extension XCTest {
    
    func given(_ text: String, step: (() -> Void )? = nil) {
        XCTContext.runActivity(named: "Given " + text) { _ in
            step?()
        }
    }
    
    func when(_ text: String, step: (() -> Void )? = nil) {
        XCTContext.runActivity(named: "When " + text) { _ in
            step?()
        }
    }
    
    func then(_ text: String, step: (() -> Void )? = nil) {
        XCTContext.runActivity(named: "Then " + text) { _ in
            step?()
        }
    }
    
    func and(_ text: String, step: (() -> Void )? = nil) {
        XCTContext.runActivity(named: "And " + text) { _ in
            step?()
        }
    }
}

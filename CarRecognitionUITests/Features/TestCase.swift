//
//  TestCase.swift
//  CarRecognitionUITests
//

import XCTest

class TestCase: XCTestCase {
    
    lazy var app: Screen = Screen(XCUIApplication())
    
    override func setUp() {
        super.setUp()
        
        addUIInterruptionMonitor(withDescription: "“CarLens” Would Like to Access the Camera") { (alert) -> Bool in
            let okButton = alert.buttons["OK"]
            if okButton.exists {
                okButton.tap()
            }
            return true
        }
        
        app.app.launch()
    }
    
}

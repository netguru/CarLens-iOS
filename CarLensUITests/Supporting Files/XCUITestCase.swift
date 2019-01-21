//
//  XCUITestCase.swift
//  UnicornFeederUITests
//

import XCTest
import FBSnapshotTestCase

class XCUITestCase: FBSnapshotTestCase {
	
    private(set) var app: Screen!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = TestBuilder(XCUIApplication()).reset().launch()
    }
    
    func setUpAlertHandler() {
        let allowButtonPredicate = NSPredicate(format: "label == 'Always Allow' || label == 'Allow' || label == 'OK'")
        _ = addUIInterruptionMonitor(withDescription: "Alert Handler") { (alert) -> Bool in
            let alertAllowButton = alert.buttons.matching(allowButtonPredicate).element.firstMatch
            if alertAllowButton.exists {
                alertAllowButton.tap()
                return true
            }
            return false
        }
    }
}

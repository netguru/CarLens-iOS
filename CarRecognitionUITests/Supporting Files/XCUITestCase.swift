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
        setUpAlertHandler()
        app = TestBuilder(XCUIApplication()).reset().launch()
    }
    
    private func setUpAlertHandler() {
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

extension XCTestCase {
    
    func wait(for duration: TimeInterval) {
        let waitExpectation = expectation(description: "Waiting for snapshot")
        let when = DispatchTime.now() + duration
        DispatchQueue.main.asyncAfter(deadline: when) {
            waitExpectation.fulfill()
        }
		
        waitForExpectations(timeout: duration)
    }
}

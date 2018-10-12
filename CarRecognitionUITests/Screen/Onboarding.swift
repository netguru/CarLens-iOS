//
//  Onboarding.swift
//  CarRecognitionUITests
//


import Foundation
import FBSnapshotTestCase

internal final class Onboarding: Screen {
    
    override var viewIdentifier: String {
        return "onboarding/view"
    }
    
    @discardableResult
    func goToRecognitionView() -> Screen {
        let buttons = self.app.buttons.matching(identifier: "onboarding/button")
        if buttons.count > 0 {
            let firstButton = buttons.element(boundBy: 0)
            firstButton.tap()
        }
        return self
    }
}

//
//  Onboarding.swift
//  CarLensUITests
//


import Foundation
import FBSnapshotTestCase

internal final class Onboarding: Screen {
    
    private lazy var nextButton = app.buttons["onboarding/button/next"]
    
    override var viewIdentifier: String {
        return "onboarding/view/main"
    }
    
    @discardableResult
    func goToRecognitionView() -> Screen {
        nextButton.tap()
        nextButton.tap()
        nextButton.tap()
        return self
    }
}

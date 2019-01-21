//
//  TestBuilder.swift
//  CarLensUITests
//

import XCTest

final class TestBuilder {
    
    let app: XCUIApplication
    
    required init(_ app: XCUIApplication) {
        self.app = app
    }
    
    func reset() -> Self {
        app.launchArguments += ["-UITests"]
        app.launchEnvironment = ["DISABLE_ANIMATIONS": "1"]
        return self
    }
    
    func launch() -> Screen {
        app.launch()
        return Screen(app)
    }
}

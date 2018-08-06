//
//  Recognition.swift
//  CarRecognitionUITests
//


import Foundation

final class Recognition: Screen {
    
    private lazy var carsButton = app.buttons["recognition/button/cars"]
    
    override var viewIdentifier: String {
        return "recognition/view/main"
    }
    
    @discardableResult
    func goToCarsView() -> Screen {
        carsButton.tap()
        return self
    }
}

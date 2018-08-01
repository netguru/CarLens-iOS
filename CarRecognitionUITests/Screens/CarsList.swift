//
//  CarsList.swift
//  CarRecognitionUITests
//


import Foundation
import XCTest

final class CarsList: Screen {
    
    private lazy var recognizeButton = app.buttons["carsList/button/recognize"]
    private lazy var ovalProgressView = app.otherElements["carsList/view/ovalProgress"]
    private lazy var carsCollectionView = app.collectionViews["carsList/collectionView/cars"]
    private lazy var carsListNavigationBar = app.otherElements["carsList/navigationBar/main"]
    
    override var viewIdentifier: String {
        return "carsList/view/main"
    }
    
    var isProgressViewVisible: Bool {
        return exists(ovalProgressView)
    }
    
    var isCarsCollectionViewVisible: Bool {
        return exists(carsCollectionView)
    }
    
    var isCarsListNavigationBarVisible: Bool {
        return exists(carsListNavigationBar)
    }
    
    @discardableResult
    func goToRecognitionView() -> Screen {
        recognizeButton.tap()
        return self
    }
}

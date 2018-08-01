//
//  CarsListTestCase.swift
//  CarRecognitionUITests
//


import XCTest

final class CarsListTestCase: XCTestCase {
    
    lazy var app: Screen = Screen(XCUIApplication())
    
    override func setUp() {
        super.setUp()
        
        app.app.launch()
        given("being on cars list view") {
            self.app.on(screen: Recognition.self).goToCarsView()
        }
    }
    
    func testProgressViewVisibility() {
        then("progressView should be visible") {
          XCTAssertTrue(self.app.on(screen: CarsList.self).isProgressViewVisible)
        }
    }
    
    func testCarsCollectionViewVisibility() {
        then("carsCollectionView should be visible") {
            XCTAssertTrue(self.app.on(screen: CarsList.self).isCarsCollectionViewVisible)
        }
    }
    
    func testCarsListNavigationBarVisibility() {
        then("carsListNavigationBar should be visible") {
            XCTAssertTrue(self.app.on(screen: CarsList.self).isCarsListNavigationBarVisible)
        }
    }
    
    func testVisibilityAfterComingBackToRecognition() {
        when("coming to recognition") {
            self.app.on(screen: CarsList.self).goToRecognitionView()
        }
        
        then("cars list view should not be visible") {
            XCTAssertFalse(self.app.on(screen: CarsList.self).isDisplayed)
        }
        
        then("recognition should be visible") {
            XCTAssertTrue(self.app.on(screen: Recognition.self).isDisplayed)
        }
    }
}

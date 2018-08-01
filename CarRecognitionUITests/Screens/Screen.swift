//
//  Screen.swift
//  CarRecognitionUITests
//


import Foundation
import XCTest

enum UIState: String {
    case exist = "exists == true"
    case notExist = "exists == false"
    case hittable = "isHittable == true"
}

protocol Displayable {
    var viewIdentifier: String { get }
}

class Screen: Displayable {
    
    // MARK: Displayable
    
    var viewIdentifier: String {
        return ""
    }
    
    // MARK: Properties
    
    let app: XCUIApplication
    
    var mainView: XCUIElement {
        return self.app.otherElements[viewIdentifier]
    }
    
    var isDisplayed: Bool {
        return exists(mainView)
    }
    
    required init(_ app: XCUIApplication) {
        self.app = app
    }
    
    // MARK: Functions
    
    func on<T: Screen>(screen: T.Type) -> T {
        if self is T {
            return self as! T
        }
        return screen.init(app)
    }
    
    // MARK: Interactions
    
    func tap(_ element: XCUIElement) {
        wait(for: element, status: .hittable)
        element.tap()
    }
    
    func tap(_ element: XCUIElement, times: Int) {
        wait(for: element, status: .hittable)
        element.tap(withNumberOfTaps: times, numberOfTouches: 1)
    }
    
    func tap(text: String) {
        let element = app.staticTexts[text]
        wait(for: element, status: .hittable)
        element.tap()
    }
    
    func typeInto(_ element: XCUIElement, text: String) {
        wait(for: element, status: .exist)
        element.typeText(text)
    }
    
    func tapAndTypeInto(_ element: XCUIElement, text: String) {
        tap(element)
        typeInto(element, text: text)
    }
    
    @discardableResult
    func wait(for duration: TimeInterval) -> Screen {
        let expectation = XCTestExpectation(description: "Waiting")
        _ = XCTWaiter.wait(for: [expectation], timeout: TimeInterval(duration + 1))
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            expectation.fulfill()
        }
        return self
    }
    
    @discardableResult
    func wait(for element: XCUIElement, status: UIState, timeout: Int = 12) -> XCUIElement {
        let expectation = XCTNSPredicateExpectation(predicate: NSPredicate(format: status.rawValue), object: element)
        if XCTWaiter.wait(for: [expectation], timeout: TimeInterval(timeout)) == .timedOut {
            XCTFail(expectation.description)
        }
        return element
    }
    
    // MARK: Expectations
    
    func exists(_ element: XCUIElement, timeout: Int = 12) -> Bool {
        let expectation = XCTNSPredicateExpectation(predicate: NSPredicate(format: UIState.exist.rawValue), object: element)
        return XCTWaiter.wait(for: [expectation], timeout: TimeInterval(timeout)) != .timedOut
    }
}

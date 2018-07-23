//
//  LocalCarsDataServiceTests.swift
//  CarRecognitionTests
//


@testable import CarRecognition
import XCTest

class LocalCarsDataServiceTests: XCTestCase {
    
    func testCarsInitialization() {
        let dataService = LocalCarsDataService()
        XCTAssert(!dataService.cars.isEmpty, "Local Cars Data Service should initialize the not empty cars array from JSON.")
    } 
}

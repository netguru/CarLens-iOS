//
//  LocalCarsDataServiceTests.swift
//  CarRecognitionTests
//


@testable import CarRecognition
import XCTest

class LocalCarsDataServiceTests: XCTestCase {
    
    var sut: LocalCarsDataService!
    
    func testCarsInitialization() {
        sut = LocalCarsDataService(with: Bundle(for: type(of: self)).path(forResource: "cars", ofType: "json"))
        XCTAssert(!sut.cars.isEmpty, "Local Cars Data Service should initialize the not empty cars array from JSON.")
    } 
}

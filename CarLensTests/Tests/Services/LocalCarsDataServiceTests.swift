//
//  LocalCarsDataServiceTests.swift
//  CarLensTests
//


@testable import CarLens
import XCTest

final class LocalCarsDataServiceTests: XCTestCase {
    
    var sut: LocalCarsDataService!
    
    override func setUp() {
        super.setUp()
        let path = Bundle(for: type(of: self)).path(forResource: "MockedCars", ofType: "json")
        sut = LocalCarsDataService(with: path)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testCarsInitialization() {
        XCTAssert(!sut.cars.isEmpty, "Local Cars Data Service should initialize the not empty cars array from JSON.")
    } 
}

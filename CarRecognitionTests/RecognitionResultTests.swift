//
//  RecognitionResultTests.swift
//  CarRecognitionTests
//


@testable import CarRecognition
import XCTest

final class RecognitionResultTests: XCTestCase {
    
    struct Labels {
        static let otherCar = "other car"
        static let notCar = "not car"
        static let unknown = "unknown label"
    }
    
    var sut: RecognitionResult?
    var localCarDataService: LocalCarsDataService!
    var carsDataService: CarsDataService!
    
    override func setUp() {
        super.setUp()
        localCarDataService = LocalCarsDataService()
        carsDataService = CarsDataService()
    }

    override func tearDown() {
        localCarDataService = nil
        carsDataService = nil
        super.tearDown()
    }
    
    func testInitizationForCar() {
        let car = localCarDataService.cars.first
        XCTAssertNotNil(car, "Local car data base should not be empty.")
        guard let firstCar = car else { return }
        testResult(for: firstCar.id)
        guard let result = sut else { return }
        XCTAssertEqual(result.recognition, RecognitionResult.Recognition.car(firstCar), "Recognition Result should return car for its label.")
    }
    
    func testInitizationForOtherCar() {
        testResult(for: Labels.otherCar)
        guard let result = sut else { return }
        XCTAssertEqual(result.recognition, RecognitionResult.Recognition.otherCar, "Recognition Result should return otherCar enum type for label that's not in local data base.")
    }
    
    func testInitizationForNotCar() {
        testResult(for: Labels.notCar)
        guard let result = sut else { return }
        XCTAssertEqual(result.recognition, RecognitionResult.Recognition.notCar, "Recognition Result should return notCar enum type for label 'not car'.")
    }
   
    func testInitizationForUnknownLabel() {
        sut = RecognitionResult(label: Labels.unknown, confidence: 0.9, carsDataService: carsDataService)
        XCTAssertNil(sut, "Recognition Result should fail to initialize for an unknown label.")
    }
    
    private func testResult(for label: String) {
        sut = RecognitionResult(label: label, confidence: 0.9, carsDataService: carsDataService)
        XCTAssertNotNil(sut, "Recognition Result should not be empty.")
    }
}

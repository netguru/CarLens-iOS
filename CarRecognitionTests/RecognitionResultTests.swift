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
        guard let firstCar = car,
            let result = result(for: firstCar.id) else { return }
        XCTAssertEqual(result.recognition, RecognitionResult.Recognition.car(firstCar), "Recognition Result should return car for its label.")
    }
    
    func testInitizationForOtherCar() {
        guard let result = result(for: Labels.otherCar) else { return }
        XCTAssertEqual(result.recognition, RecognitionResult.Recognition.otherCar, "Recognition Result should return otherCar enum type for label that's not in local data base.")
    }
    
    func testInitizationForNotCar() {
        guard let result = result(for: Labels.notCar) else { return }
        XCTAssertEqual(result.recognition, RecognitionResult.Recognition.notCar, "Recognition Result should return notCar enum type for label 'not car'.")
    }
   
    func testInitizationForUnknownLabel() {
        let result = RecognitionResult(label: Labels.unknown, confidence: 0.9, carsDataService: carsDataService)
        XCTAssertNil(result, "Recognition Result should fail to initialize for an unknown label.")
    }
    
    private func result(for label: String) -> RecognitionResult? {
        let result = RecognitionResult(label: label, confidence: 0.9, carsDataService: carsDataService)
        XCTAssertNotNil(result, "Recognition Result should not be empty.")
        return result
    }
}

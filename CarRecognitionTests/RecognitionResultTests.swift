//
//  RecognitionResultTests.swift
//  CarRecognitionTests
//


@testable import CarRecognition
import XCTest

final class RecognitionResultTests: XCTestCase {
    
    private struct Labels {
        static let otherCar = "other car"
        static let notCar = "not a car"
        static let unknown = "unknown label"
    }
    
    var sut: RecognitionResult!
    
    func testInitizationForCar() {
        let car = LocalCarsDataService().cars.first
        XCTAssertNotNil(car, "Local car data base should not be empty.")
        guard let firstCar = car else { return }
        testResult(for: firstCar.id)
        guard let result = sut else { return }
        XCTAssertEqual(result.recognition, RecognitionResult.Recognition.car(firstCar), "Recognition Result should return car for its label.")
    }
    
    func testInitializationForOtherCar() {
        testResult(for: Labels.otherCar)
        guard let result = sut else { return }
        XCTAssertEqual(result.recognition, RecognitionResult.Recognition.otherCar, "Recognition Result should return otherCar enum type for label that's not in local data base.")
    }
    
    func testInitializationForNotCar() {
        testResult(for: Labels.notCar)
        guard let result = sut else { return }
        XCTAssertEqual(result.recognition, RecognitionResult.Recognition.notCar, "Recognition Result should return notCar enum type for label 'not car'.")
    }
   
    func testInitializationForUnknownLabel() {
        sut = RecognitionResult(label: Labels.unknown, confidence: 0.9, carsDataService: CarsDataService())
        XCTAssertNil(sut, "Recognition Result should fail to initialize for an unknown label.")
    }
    
    private func testResult(for label: String) {
        sut = RecognitionResult(label: label, confidence: 0.9, carsDataService: CarsDataService())
        XCTAssertNotNil(sut, "Recognition Result should not be empty.")
    }
}

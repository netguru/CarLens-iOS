//
//  RecognitionResultTests.swift
//  CarLensTests
//


@testable import CarLens
import XCTest

final class RecognitionResultTests: XCTestCase {
    
    struct Labels {
        static let otherCar = "other_car"
        static let notCar = "0"
        static let unknown = "unknown label"
    }
    
    var sut: RecognitionResult!
    
    var localCarsDataService: LocalCarsDataService!
    
    var carsDataService: CarsDataService!
    
    override func setUp() {
        super.setUp()
        let path = Bundle(for: type(of: self)).path(forResource: "MockedCars", ofType: "json")
        localCarsDataService = LocalCarsDataService(with: path)
        carsDataService = CarsDataService(localDataService: localCarsDataService)
    }
    
    override func tearDown() {
        sut = nil
        localCarsDataService = nil
        carsDataService = nil
        super.tearDown()
    }
    
    func testInitizationForCar() {
        guard let firstCar = localCarsDataService.cars.first else {
            XCTFail("Local car data base should not be empty.")
            return
        }
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
        sut = RecognitionResult(label: label, confidence: 0.9, carsDataService: CarsDataService(localDataService: localCarsDataService))
        XCTAssertNotNil(sut, "Recognition Result should not be empty.")
    }
}

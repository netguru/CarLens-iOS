//
//  CarsDataServiceTests.swift
//  CarRecognitionTests
//

@testable import CarRecognition
import XCTest

class CarsDataServiceTests: XCTestCase {
    
    var sut: CarsDataService!
    var localCarsDataService: LocalCarsDataService!
    
    override func setUp() {
        super.setUp()
        let path = Bundle(for: type(of: self)).path(forResource: "cars", ofType: "json")
        localCarsDataService = LocalCarsDataService(with: path)
        sut = CarsDataService(localDataService: localCarsDataService)
    }
    
    override func tearDown() {
        localCarsDataService = nil
        sut = nil
        super.tearDown()
    }
    
    func testMapClassifierForLabel() {
        // given
        guard let car = testFirstCar() else { return }
        // when
        let result = sut.map(classifierLabel: car.id)
        //then
        XCTAssertEqual(result, car, "Cars Data Service should return car object for its label.")
    }
    
    func testMapClassifierForUnknownLabel() {
        // given
        let uknownLabel = "uknown"
        // when
        let result = sut.map(classifierLabel: uknownLabel)
        //then
        XCTAssertNil(result, "Cars Data Service should return nil for uknown label.")
    }
    
    func testAvailableCars() {
        //TODO: test databaseService.mapDiscoveredParameter(for: &cars)
        XCTAssertEqual(sut.getAvailableCars(), localCarsDataService.cars, "Cars received from the Cars Data Service should be the same as in the local data.")
    }
    
    func testNumberOfCars() {
        XCTAssertEqual(sut.getNumberOfCars(), localCarsDataService.cars.count, "Number of cars received from the Cars Data Service should be the same as in the local data.")
    }
    //todo mark car
    
    func testMarkCar() {
        let firstCar = localCarsDataService.cars.first
        XCTAssertNotNil(firstCar, "First car in local data base should not be empty.")
        guard let car = testFirstCar() else { return }
        sut.mark(car: car, asDiscovered: true)
//        XCTAssertEqual(car.isDiscovered, true, "Car should be marked as discovered.")
        sut.mark(car: car, asDiscovered: false)
//        XCTAssertEqual(car.isDiscovered, false, "Car should be marked as undiscovered.")
        //TODO: userdefaults?
    }
    
    private func testFirstCar() -> Car? {
        let firstCar = localCarsDataService.cars.first
        XCTAssertNotNil(firstCar, "First car in local data base should not be empty.")
        return firstCar
    }
}

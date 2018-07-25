//
//  CarsDataServiceTests.swift
//  CarRecognitionTests
//

@testable import CarRecognition
import XCTest

final class CarsDataServiceTests: XCTestCase {
    
    var sut: CarsDataService!
    var localCarsDataService: LocalCarsDataService!
    var databaseService: CarsDatabaseService!
    
    override func setUp() {
        super.setUp()
        let path = Bundle(for: type(of: self)).path(forResource: "cars", ofType: "json")
        localCarsDataService = LocalCarsDataService(with: path)
        databaseService = CarsDatabaseService()
        sut = CarsDataService(localDataService: localCarsDataService, databaseService: databaseService)
    }
    
    override func tearDown() {
        localCarsDataService = nil
        databaseService = nil
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
        // then
        XCTAssertNil(result, "Cars Data Service should return nil for uknown label.")
    }
    
    func testAvailableCars() {
        // given
        var expectedCars = localCarsDataService.cars
        XCTAssertNil(expectedCars.first, "Cars local data for tests should not be empty.")
        guard var firstCar = expectedCars.first else { return }
        sut.mark(car: firstCar, asDiscovered: true)
        firstCar.isDiscovered = true
        expectedCars[0] = firstCar
        // when
        let result = sut.getAvailableCars()
        // then
        XCTAssertEqual(result, expectedCars, "Cars received from the Cars Data Service should be the same as in the local data.")
    }
    
    func testNumberOfCars() {
        XCTAssertEqual(sut.getNumberOfCars(), localCarsDataService.cars.count, "Number of cars received from the Cars Data Service should be the same as in the local data.")
    }
   
    func testMarkCar() {
        let firstCar = localCarsDataService.cars.first
        XCTAssertNotNil(firstCar, "First car in local data base should not be empty.")
        guard let car = testFirstCar() else { return }
        sut.mark(car: car, asDiscovered: true)
        let markedCar = sut.getAvailableCars().filter({ $0.id == car.id }).first
        XCTAssertNotNil(markedCar, "Updated car after marking should not be nil.")
        guard let updatedCar = markedCar else { return }
        XCTAssertEqual(car, updatedCar, "Car should be marked as discovered.")
    }
    
    private func testFirstCar() -> Car? {
        let firstCar = localCarsDataService.cars.first
        XCTAssertNotNil(firstCar, "First car in local data base should not be empty.")
        return firstCar
    }
}

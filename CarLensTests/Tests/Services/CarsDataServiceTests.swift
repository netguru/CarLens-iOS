//
//  CarsDataServiceTests.swift
//  CarLensTests
//

@testable import CarLens
import XCTest

final class CarsDataServiceTests: XCTestCase {
    
    var sut: CarsDataService!
    
    var localCarsDataService: LocalCarsDataService!
    
    var databaseService: CarsDatabaseService!
    
    override func setUp() {
        super.setUp()
        let path = Bundle(for: type(of: self)).path(forResource: "MockedCars", ofType: "json")
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
        // then
        XCTAssertEqual(result, car, "Cars Data Service should return car object for its label.")
    }
    
    func testMapClassifierForUnknownLabel() {
        // given
        let unknownLabel = "unknown"
        // when
        let result = sut.map(classifierLabel: unknownLabel)
        // then
        XCTAssertNil(result, "Cars Data Service should return nil for unknown label.")
    }
    
    func testAvailableCars() {
        // given
        var expectedCars = localCarsDataService.cars
        guard var firstCar = expectedCars.first else {
            XCTFail("Cars local data for tests should not be empty.")
            return
        }
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
        // given
        guard let car = testFirstCar() else { return }
        // when
        sut.mark(car: car, asDiscovered: true)
        guard let markedCar = sut.getAvailableCars().filter({ $0.id == car.id }).first else {
            XCTFail("Updated car after marking should not be nil.")
            return
        }
        // then
        XCTAssertEqual(car, markedCar, "Car should be marked as discovered.")
    }
    
    private func testFirstCar() -> Car? {
        let firstCar = localCarsDataService.cars.first
        XCTAssertNotNil(firstCar, "First car in local data base should not be empty.")
        return firstCar
    }
}

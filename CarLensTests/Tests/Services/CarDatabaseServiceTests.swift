//
//  CarDatabaseServiceTests.swift
//  CarLensTests
//

@testable import CarLens
import XCTest

final class CarsDatabaseServiceTests: XCTestCase {

    var sut: CarsDatabaseService!

    var car: Car!

    override func setUp() {
        super.setUp()
        sut = CarsDatabaseService()
        car = Car.make()
    }

    override func tearDown() {
        super.tearDown()
        car = nil
        sut = nil
    }

    func testCarAsDiscovered() {
        XCTAssertNotNil(car, "Car should't be nil")
        guard var car = car else { return }
        sut.mark(car: car, asDiscovered: true)
        sut.mapDiscoveredParameter(car: &car)
        XCTAssertTrue(car.isDiscovered, "Car should be marked as discovered")
    }

    func testCarAsNotDiscovered() {
        XCTAssertNotNil(car, "Car should't be nil")
        guard var car = car else { return }
        sut.mark(car: car, asDiscovered: false)
        sut.mapDiscoveredParameter(car: &car)
        XCTAssertFalse(car.isDiscovered, "Car should be marked as undiscovered")
    }

    func testMultipleCarsAsDiscovered() {
        XCTAssertNotNil(car, "Car should't be nil")
        guard let car = car else { return }
        sut.mark(car: car, asDiscovered: true)
        var cars = [car, car, car, car]
        sut.mapDiscoveredParameter(for: &cars)
        for mappedCar in cars {
            XCTAssertTrue(mappedCar.isDiscovered, "Car should be marked as discovered")
        }
    }
}

//
//  CarDatabaseServiceTests.swift
//  CarRecognitionTests
//


@testable import CarRecognition
import XCTest

final class CarsDatabaseServiceTests: XCTestCase {

    var sut: CarsDatabaseService!

    var car: Car!

    override func setUp() {
        sut = CarsDatabaseService()
        car = Car.make()
    }

    func testCarAsDiscovered() {
        guard var car = car else { return }
        sut.mark(car: car, asDiscovered: true)
        sut.mapDiscoveredParameter(car: &car)
        XCTAssertTrue(car.isDiscovered, "Car should be marked as discovered")
    }

    func testCarAsNotDiscovered() {
        guard var car = car else { return }
        sut.mark(car: car, asDiscovered: false)
        sut.mapDiscoveredParameter(car: &car)
        XCTAssertFalse(car.isDiscovered, "Car should be marked as undiscovered")
    }

    func testMultipleCarsAsDiscovered() {
        guard let car = car else { return }
        sut.mark(car: car, asDiscovered: true)
        var cars = [car, car, car, car]
        sut.mapDiscoveredParameter(for: &cars)
        for mappedCar in cars {
            XCTAssertTrue(mappedCar.isDiscovered, "Car should be marked as discovered")
        }
    }
}

//
//  CarTests.swift
//  CarRecognitionTests
//


@testable import CarRecognition
import XCTest

final class CarTests: XCTestCase {

    private struct Constants {
        static let makeName = "Ford"
        static let modelName = "Fiesta"
        static let engine = 1000
        static let power = 70
        static let id = "FordFiesta"
        static let stars = 1
        static let image = CarImage(unlocked: #imageLiteral(resourceName: "FordFiesta"), locked: #imageLiteral(resourceName: "FordFiesta_locked"), logoUnlocked: #imageLiteral(resourceName: "Ford"), logoLocked: #imageLiteral(resourceName: "Ford_locked"))
        static let description = "Ford Fiesta has been marketed by Ford since 1976. Ford has sold over 16 million Fiestas since then, making it a best-seller."
        static let isDiscovered = false
    }

    var sut: Car!

    override func setUp() {
        sut = Car.make()
    }

    func testCarInitialization() {
        XCTAssertNotNil(sut, "Car shouldn't be nil")
    }

    func testCarProperties() {
        XCTAssertEqual(sut.make, Constants.makeName, "Car's make should be equal to \(Constants.makeName)")
        XCTAssertEqual(sut.model, Constants.modelName, "Car's model should be equal to \(Constants.modelName)")
        XCTAssertEqual(sut.engine, Constants.engine, "Car's engine should be equal to \(Constants.engine)")
        XCTAssertEqual(sut.power, Constants.power, "Car's power should be equal to \(Constants.power)")
        XCTAssertEqual(sut.id, Constants.id, "Car's id should be equal to \(Constants.id)")
        XCTAssertEqual(sut.stars, Constants.stars, "Car's stars should be equal to \(Constants.stars)")
        XCTAssertEqual(sut.image, Constants.image, "Car's image should be equal to \(Constants.image)")
        XCTAssertEqual(sut.description, Constants.description, "Car's description should be equal to \(Constants.description)")
        XCTAssertEqual(sut.isDiscovered, Constants.isDiscovered, "Car's idDiscovered property should be equal to \(Constants.isDiscovered)")
    }
}

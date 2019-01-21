//
//  CarTests.swift
//  CarLensTests
//


@testable import CarLens
import XCTest

final class CarTests: XCTestCase {

    private struct DesiredParameters {
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
        super.setUp()
        sut = Car.make()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func testCarInitialization() {
        XCTAssertNotNil(sut, "Car shouldn't be nil")
    }

    func testCarProperties() {
        XCTAssertEqual(sut.make, DesiredParameters.makeName, "Car's make should be equal to \(DesiredParameters.makeName)")
        XCTAssertEqual(sut.model, DesiredParameters.modelName, "Car's model should be equal to \(DesiredParameters.modelName)")
        XCTAssertEqual(sut.engine, DesiredParameters.engine, "Car's engine should be equal to \(DesiredParameters.engine)")
        XCTAssertEqual(sut.power, DesiredParameters.power, "Car's power should be equal to \(DesiredParameters.power)")
        XCTAssertEqual(sut.id, DesiredParameters.id, "Car's id should be equal to \(DesiredParameters.id)")
        XCTAssertEqual(sut.stars, DesiredParameters.stars, "Car's stars should be equal to \(DesiredParameters.stars)")
        XCTAssertEqual(sut.image, DesiredParameters.image, "Car's image should be equal to \(DesiredParameters.image)")
        XCTAssertEqual(sut.description, DesiredParameters.description, "Car's description should be equal to \(DesiredParameters.description)")
        XCTAssertEqual(sut.isDiscovered, DesiredParameters.isDiscovered, "Car's idDiscovered property should be equal to \(DesiredParameters.isDiscovered)")
    }
}

//
//  CarTests.swift
//  CarRecognitionTests
//


@testable import CarRecognition
import XCTest

final class CarTests: XCTestCase {

    /// Object under tests
    var sut: Car!

    /// Method which tests model name for given car
    func testModelName() {
        sut = Car.known(make: .volkswagen, model: "Passat")
        XCTAssert(sut.model == "Passat")
    }

    /// Method which tests brand name for given car
    func testBrandName() {
        sut = Car.known(make: .honda, model: "Civic")
        XCTAssert(sut.brand == "Honda")
    }

    /// Method which tests image for given car
    func testCarImage() {
        sut = Car.known(make: .volkswagen, model: "Tiguan")
        XCTAssert(sut.image == #imageLiteral(resourceName: "VolkswagenTiguan"))
        
        sut = Car.known(make: .volkswagen, model: "Passat")
        XCTAssert(sut.image == #imageLiteral(resourceName: "VolkswagenPassat"))
        
        sut = Car.known(make: .volkswagen, model: "Golf")
        XCTAssert(sut.image == #imageLiteral(resourceName: "VolkswagenGolf"))
        
        sut = Car.other
        XCTAssert(sut.image == #imageLiteral(resourceName: "VolkswagenPassat_locked"))
    }

    /// Method which tests description for given car
    func testDescription() {
        sut = Car.known(make: .ford, model: "Fiesta")
        XCTAssert(sut.description == "Ford Fiesta")
    }
}

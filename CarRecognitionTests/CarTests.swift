//
//  CarTests.swift
//  CarRecognitionTests
//


@testable import CarRecognition
import XCTest

final class CarTests: XCTestCase {

    var sut: Car!

    func testModelName() {
        sut = Car.known(make: .volkswagen, model: "Passat")
        XCTAssert(sut.model == "Passat")
    }

    func testBrandName() {
        sut = Car.known(make: .honda, model: "Civic")
        XCTAssert(sut.brand == "Honda")
    }

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

    func testDescription() {
        sut = Car.known(make: .ford, model: "Fiesta")
        XCTAssert(sut.description == "Ford Fiesta")
    }
}

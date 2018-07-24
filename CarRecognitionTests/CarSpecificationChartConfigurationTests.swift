//
//  CarSpecificationChartConfigurationTests.swift
//  CarRecognitionTests
//


@testable import CarRecognition
import XCTest

final class CarSpecificationChartConfigurationTests: XCTestCase {

    var sut: CarSpecificationChartConfiguration!

    override func setUp() {
        sut = CarSpecificationChartConfiguration()
    }

    func testCarSpecificationParameters() {
        XCTAssertEqual(sut.referenceHorsePower, 320, "Reference horse power should be equal to 320")
        XCTAssertEqual(sut.referenceSpeed, 200, "Reference speed should be equal to 200")
        XCTAssertEqual(sut.referenceEngineVolume, 4000, "Reference engine volume should be equal to 4000")
        XCTAssertEqual(sut.referenceMaxAccelerate, 20, "Reference maximum accelerate should be equal to 20")
        XCTAssertEqual(sut.referenceMinAccelerate, 2.9, "Reference minimum accelerate should be equal to 2.9")
    }
}

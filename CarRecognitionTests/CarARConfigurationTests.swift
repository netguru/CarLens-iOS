//
//  CarARConfigurationTests.swift
//  CarRecognitionTests
//


@testable import CarRecognition
import XCTest

final class CarARConfigurationTests: XCTestCase {

    var sut: CarARConfiguration!

    override func setUp() {
        sut = CarARConfiguration()
    }

    func testConfigurationParameters() {
        XCTAssertEqual(sut.pointForHitTest, CGPoint(x: 0.5, y: 0.5), "Point for hit test should be equal to (0.5, 0.5)")
        XCTAssertEqual(sut.neededConfidenceToPinLabel, 0.96, "Needed confidence to pin the label should be equal to 0.96")
        XCTAssertEqual(sut.normalizationCount, 10, "Normalization count should be equal to 10")
    }

    func testEnvironmentVariables() {
        #if ENV_TESTS
            XCTAssertEqual(sut.nodeShift, NodeShift(depth: 0, elevation: 0), "Node shift should be equal to (depth: 0, elevation: 0)")
            XCTAssertEqual(sut.minimumDistanceFromDevice, 0.1, "Miinmum distance from device should be equal to 0.1")
            XCTAssertEqual(sut.minimumDistanceBetweenNodes, 0.2, "Mininmum distance between nodes should be equal to 0.2")
            XCTAssertEqual(sut.maximumDistanceFromDevice, 2, "Maximum distance from device should be equal to 2")
        #endif
    }
}

//
//  CarARConfigurationTests.swift
//  CarRecognitionTests
//


@testable import CarRecognition
import XCTest

final class CarARConfigurationTests: XCTestCase {
    
    private struct DesiredParameters {
        static let pointForHitTest = CGPoint(x: 0.5, y: 0.5)
        static let neededConfidenceToPinLabel = 0.96
        static let normalizationCount = 10
        static let nodeShift = NodeShift(depth: 0, elevation: 0)
        static let minimumDistanceFromDevice: CGFloat = 0.1
        static let minimumDistanceBetweenNodes: Float = 0.2
        static let maximumDistanceFromDevice: CGFloat = 2
    }

    var sut: CarARConfiguration!

    override func setUp() {
        super.setUp()
        sut = CarARConfiguration()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func testConfigurationParameters() {
        XCTAssertEqual(sut.pointForHitTest, DesiredParameters.pointForHitTest, "Point for hit test should be equal to \(DesiredParameters.pointForHitTest)")
        XCTAssertEqual(sut.neededConfidenceToPinLabel, DesiredParameters.neededConfidenceToPinLabel, "Needed confidence to pin the label should be equal to \(DesiredParameters.neededConfidenceToPinLabel)")
        XCTAssertEqual(sut.normalizationCount, DesiredParameters.normalizationCount, "Normalization count should be equal to \(DesiredParameters.normalizationCount)")
    }

    func testEnvironmentVariables() {
        #if ENV_TESTS
            XCTAssertEqual(sut.nodeShift, DesiredParameters.nodeShift, "Node shift should be equal to \(DesiredParameters.nodeShift)")
            XCTAssertEqual(sut.minimumDistanceFromDevice, DesiredParameters.minimumDistanceFromDevice, "Miinmum distance from device should be equal to \(DesiredParameters.minimumDistanceFromDevice)")
            XCTAssertEqual(sut.minimumDistanceBetweenNodes, DesiredParameters.minimumDistanceBetweenNodes, "Mininmum distance between nodes should be equal to \(DesiredParameters.minimumDistanceBetweenNodes)")
            XCTAssertEqual(sut.maximumDistanceFromDevice, DesiredParameters.maximumDistanceFromDevice, "Maximum distance from device should be equal to \(DesiredParameters.maximumDistanceFromDevice)")
        #endif
    }
}

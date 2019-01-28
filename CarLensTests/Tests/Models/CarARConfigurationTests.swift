//
//  CarARConfigurationTests.swift
//  CarLensTests
//

@testable import CarLens
import XCTest

final class CarARConfigurationTests: XCTestCase {

    private enum DesiredParameters {
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
        XCTAssertEqual(sut.pointForHitTest,
                       DesiredParameters.pointForHitTest,
                       "Point for hit test should be equal to \(DesiredParameters.pointForHitTest)")
    }

    func testEnvironmentVariables() {
        #if ENV_TESTS
            XCTAssertEqual(sut.nodeShift,
                           DesiredParameters.nodeShift,
                           "Node shift should be equal to \(DesiredParameters.nodeShift)")
            XCTAssertEqual(sut.minimumDistanceFromDevice,
                           DesiredParameters.minimumDistanceFromDevice,
                           "Minimal distance from device should be equal to" +
                            "\(DesiredParameters.minimumDistanceFromDevice)")
            XCTAssertEqual(sut.minimumDistanceBetweenNodes,
                           DesiredParameters.minimumDistanceBetweenNodes,
                           "Minimal distance between nodes should be equal to" +
                           "\(DesiredParameters.minimumDistanceBetweenNodes)")
            XCTAssertEqual(sut.maximumDistanceFromDevice,
                           DesiredParameters.maximumDistanceFromDevice,
                           "Maximal distance from device should be equal to" +
                           "\(DesiredParameters.maximumDistanceFromDevice)")
        #endif
    }
}

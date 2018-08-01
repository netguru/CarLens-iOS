//
//  CarSpecificationChartConfigurationTests.swift
//  CarRecognitionTests
//


@testable import CarRecognition
import XCTest

final class CarSpecificationChartConfigurationTests: XCTestCase {
    
    private struct DesiredParameters {
        static let referenceHorsePower = 320
        static let referenceSpeedInMiles = 200
        static let referenceSpeedInKilometers = 322
        static let referenceEngineVolume = 4000
        static let referenceMaxAccelerate = 20.0
        static let referenceMinAccelerate = 2.9
    }

    var sut: CarSpecificationChartConfiguration!

    override func setUp() {
        super.setUp()
        sut = CarSpecificationChartConfiguration()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func testCarSpecificationParameters() {
        XCTAssertEqual(sut.referenceHorsePower, DesiredParameters.referenceHorsePower, "Reference horse power should be equal to \(DesiredParameters.referenceHorsePower)")
        XCTAssertEqual(sut.referenceEngineVolume, DesiredParameters.referenceEngineVolume, "Reference engine volume should be equal to \(DesiredParameters.referenceEngineVolume)")
        XCTAssertEqual(sut.referenceMaxAccelerate, DesiredParameters.referenceMaxAccelerate, "Reference maximum accelerate should be equal to \(DesiredParameters.referenceMaxAccelerate)")
        XCTAssertEqual(sut.referenceMinAccelerate, DesiredParameters.referenceMinAccelerate, "Reference minimum accelerate should be equal to \(DesiredParameters.referenceMinAccelerate)")
    }
    
    func testReferenceSpeedForMiles() {
        // given
        let speedType = SpeedMetricsType.mph
        // when
        sut = CarSpecificationChartConfiguration(with: speedType)
        // then
        XCTAssertEqual(sut.referenceSpeed, DesiredParameters.referenceSpeedInMiles, "Reference speed for miles should be equal to \(DesiredParameters.referenceSpeedInMiles)")
        
    }
    
    func testReferenceSpeedForKilometers() {
        // given
        let speedType = SpeedMetricsType.kph
        // when
        sut = CarSpecificationChartConfiguration(with: speedType)
        // then
        XCTAssertEqual(sut.referenceSpeed, DesiredParameters.referenceSpeedInKilometers, "Reference speed for kilometers should be equal to \(DesiredParameters.referenceSpeedInKilometers)")
    }
}

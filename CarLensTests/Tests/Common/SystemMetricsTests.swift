//
//  SystemMetricsTests.swift
//  CarLensTests
//

@testable import CarLens
import XCTest

final class SystemMetricsTests: XCTestCase {

    var sut: SystemMetrics!

    func testSpeedMetricsForUSLocale() {
        let locale = Locale(identifier: "en_US")
        sut = SystemMetrics(with: locale)
        XCTAssertEqual(sut.speedType, SpeedMetricsType.mph, "Should return miles for US locale")
    }

    func testSpeedMetricsForPolishLocale() {
        let locale = Locale(identifier: "pl_PL")
        sut = SystemMetrics(with: locale)
        XCTAssertEqual(sut.speedType, SpeedMetricsType.kph, "Should return kilometers for Polish locale")
    }
}

//
//  SystemMetricsTests.swift
//  CarRecognitionTests
//

@testable import CarRecognition
import XCTest

final class SystemMetricsTests: XCTestCase {
    
    func testSpeedMetricsForUSLocale() {
        let locale = Locale(identifier: "en_US")
        let systemMetrics = SystemMetrics(with: locale)
        XCTAssertEqual(systemMetrics.speedType, SpeedMetricsType.mph, "Should return miles for US locale")
    }
    
    func testSpeedMetricsForPolishLocale() {
        let locale = Locale(identifier: "pl_PL")
        let systemMetrics = SystemMetrics(with: locale)
        XCTAssertEqual(systemMetrics.speedType, SpeedMetricsType.kph, "Should return kilometers for Polish locale")
    }
}

//
//  SystemMetricsTests.swift
//  CarRecognitionTests
//

@testable import CarRecognition
import XCTest

final class SystemMetricsTests: XCTestCase {
    
    func testForUSLocale() {
        let locale = Locale(identifier: "en_US")
        let systemMetrics = SystemMetrics(with: locale)
        XCTAssertEqual(systemMetrics.speedType, SpeedMetricsType.mph, "Should return miles for us locale")
    }
    
    func testForPolishLocale() {
        let locale = Locale(identifier: "pl_PL")
        let systemMetrics = SystemMetrics(with: locale)
        XCTAssertEqual(systemMetrics.speedType, SpeedMetricsType.kph, "Should return kilometers for polish locale")
    }
}

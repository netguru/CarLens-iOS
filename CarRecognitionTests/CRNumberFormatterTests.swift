//
//  CRNumberFormatterTests.swift
//  CarRecognitionTests
//


@testable import CarRecognition
import XCTest

class CRNumberFormatterTests: XCTestCase {
    
    func testPercentageFormatterFor10Percent() {
        let given = Float(0.1)
        let percentageFormattedString = CRNumberFormatter.percentageFormatted(given)
        XCTAssertEqual(percentageFormattedString, "\(Int(given * 100))%", "Should return percentage formatted string from float.")
    }
}

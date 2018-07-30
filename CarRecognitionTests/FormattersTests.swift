//
//  FormattersTests.swift
//  CarRecognitionTests
//


@testable import CarRecognition
import XCTest

final class FormattersTests: XCTestCase {
    
    func testNumberFormatterFor10Percent() {
        let givenValue = Float(0.1)
        let percentageFormattedString = CRNumberFormatter.percentageFormatted(givenValue)
        XCTAssertEqual(percentageFormattedString, "\(Int(givenValue * 100))%", "Should return percentage formatted string from float.")
    }
    
    func testTimeFormatterFor50Miliseconds() {
        let timeInterval = 0.05
        let formattedTime = CRTimeFormatter.intervalMilisecondsFormatted(timeInterval)
        XCTAssertEqual(formattedTime, "50 ms", "Should return miliseconds formatted string from time interval.")
    }
}

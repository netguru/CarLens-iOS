//
//  InputNormalizationServiceTests.swift
//  CarRecognitionTests
//


@testable import CarRecognition
import XCTest

final class InputNormalizationServiceTests: XCTestCase {
    
    var sut: InputNormalizationService!
    
    func testInitialValueWith30LastValues() {
        sut = InputNormalizationService(numberOfValues: 30)
        let result = sut.normalize(value: 0.3)
        XCTAssertEqual(result, 0.01, accuracy: 0.01)
    }
    
    func testInitialValueWith10LastValues() {
        sut = InputNormalizationService(numberOfValues: 10)
        let result = sut.normalize(value: 0.3)
        XCTAssertEqual(result, 0.03, accuracy: 0.01)
    }
    
    func test15thWith30LastValues() {
        sut = InputNormalizationService(numberOfValues: 30)
        var result = 0.0
        for _ in 0..<15 {
            result = sut.normalize(value: 0.5)
        }
        XCTAssertEqual(result, 0.25, accuracy: 0.01)
    }
    
    func test30thWith30LastValues() {
        sut = InputNormalizationService(numberOfValues: 30)
        var result = 0.0
        for _ in 0..<30 {
            result = sut.normalize(value: 0.5)
        }
        XCTAssertEqual(result, 0.5, accuracy: 0.01)
    }
    
    func test5thWith10LastValues() {
        sut = InputNormalizationService(numberOfValues: 10)
        var result = 0.0
        for _ in 0..<5 {
            result = sut.normalize(value: 0.5)
        }
        XCTAssertEqual(result, 0.25, accuracy: 0.01)
    }
    
    func test10thWith10LastValues() {
        sut = InputNormalizationService(numberOfValues: 10)
        var result = 0.0
        for _ in 0..<10 {
            result = sut.normalize(value: 0.5)
        }
        XCTAssertEqual(result, 0.5, accuracy: 0.01)
    }
}

//
//  UIFontExtensionTests.swift
//  CarRecognitionTests
//


@testable import CarRecognition
import XCTest

final class UIFontExtensionTests: XCTestCase {

    private struct Constants {
        static let fontSize: CGFloat = 12
        static let blokkNeueFontName = "BLOKKNeue-Regular"
        static let gliscorGothicFontName = "GliscorGothic"
    }

    var sut: UIFont!

    func testGliscorGothicFont() {
        sut = UIFont.gliscorGothicFont(ofSize: Constants.fontSize)
        XCTAssertEqual(sut.pointSize, Constants.fontSize, "Font size should be \(Constants.fontSize)")
        XCTAssertEqual(sut.fontName, Constants.gliscorGothicFontName, "Font name should be \(Constants.gliscorGothicFontName)")
    }

    func testBlokkNeueFont() {
        sut = UIFont.blokkNeueFont(ofSize: Constants.fontSize)
        XCTAssertEqual(sut.pointSize, Constants.fontSize, "Font size should be '\(Constants.fontSize)'")
        XCTAssertEqual(sut.fontName, Constants.blokkNeueFontName, "Font name should be \(Constants.blokkNeueFontName)")
    }
}

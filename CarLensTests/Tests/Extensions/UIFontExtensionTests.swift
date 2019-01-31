//
//  UIFontExtensionTests.swift
//  CarLensTests
//

@testable import CarLens
import XCTest

final class UIFontExtensionTests: XCTestCase {

    private enum MockedParameters {
        static let fontSize: CGFloat = 12
        static let blokkNeueFontName = "BLOKKNeue-Regular"
        static let gliscorGothicFontName = "GliscorGothic"
    }

    var sut: UIFont!

    func testGliscorGothicFont() {
        sut = UIFont.gliscorGothicFont(ofSize: MockedParameters.fontSize)
        XCTAssertEqual(sut.pointSize, MockedParameters.fontSize, "Font size should be \(MockedParameters.fontSize)")
        XCTAssertEqual(sut.fontName,
                       MockedParameters.gliscorGothicFontName,
                       "Font name should be \(MockedParameters.gliscorGothicFontName)")
    }

    func testBlokkNeueFont() {
        sut = UIFont.blokkNeueFont(ofSize: MockedParameters.fontSize)
        XCTAssertEqual(sut.pointSize, MockedParameters.fontSize, "Font size should be '\(MockedParameters.fontSize)'")
        XCTAssertEqual(sut.fontName,
                       MockedParameters.blokkNeueFontName,
                       "Font name should be \(MockedParameters.blokkNeueFontName)")
    }
}

//
//  UIStackViewExtensionTests.swift
//  CarLensTests
//

@testable import CarLens
import XCTest

final class UIStackViewExtensionTests: XCTestCase {

    private enum MockedParameters {
        static let arrangedSubviews = [UIView(), UIButton(), UILabel()]
        static let spacing: CGFloat = 10
        static let distribution: UIStackView.Distribution = .fillEqually
        static let axis: NSLayoutConstraint.Axis = .horizontal
    }

    var sut: UIStackView!

    func testStackViewInitialization() {
        sut = .make(
            axis: MockedParameters.axis,
            with: MockedParameters.arrangedSubviews,
            spacing: MockedParameters.spacing,
            distribution: MockedParameters.distribution
        )
        XCTAssertNotNil(sut, "UIStackView shouldn't be nil")
        XCTAssertEqual(sut.axis, MockedParameters.axis, "Axis should be equal to \(MockedParameters.axis)")
        XCTAssertEqual(sut.arrangedSubviews,
                       MockedParameters.arrangedSubviews,
                       "Arranged subviews should be equal to \(MockedParameters.arrangedSubviews)")
        XCTAssertEqual(sut.spacing, MockedParameters.spacing, "Spacing should be equal to \(MockedParameters.spacing)")
        XCTAssertEqual(sut.distribution,
                       MockedParameters.distribution,
                       "Distributiion should be equal to \(MockedParameters.distribution)")
    }
}

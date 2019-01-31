//
//  CarsListTestCase.swift
//  CarLensUITests
//


import XCTest
import FBSnapshotTestCase

final class CarsListTestCase: XCUITestCase {

    override func setUp() {
        super.setUp()
        given("being on cars list view") {
            self.app.on(screen: Onboarding.self).goToRecognitionView()
            /// Waiting for a recognition screen to appear in order to add an alert handler too it
            /// It's needed to investigate whether it's the best solution to handle alerts like that
            let recognitionScreen = Recognition(self.app.app)
            self.app.wait(for: recognitionScreen.mainView, status: .exist, timeout: 5)
            super.setUpAlertHandler()
            /// Then transfering to Car List View
            self.app.on(screen: Recognition.self).goToCarsView()
        }
    }

    func testProgressViewVisibility() {
        then("progressView should be visible") {
          XCTAssertTrue(self.app.on(screen: CarsList.self).isProgressViewVisible)
        }
    }

    func testCarsCollectionViewVisibility() {
        then("carsCollectionView should be visible") {
            XCTAssertTrue(self.app.on(screen: CarsList.self).isCarsCollectionViewVisible)
        }
    }

    func testCarsListNavigationBarVisibility() {
        then("carsListNavigationBar should be visible") {
            XCTAssertTrue(self.app.on(screen: CarsList.self).isCarsListNavigationBarVisible)
        }
    }

    func testVisibilityAfterComingBackToRecognition() {
        when("coming to recognition") {
            self.app.on(screen: CarsList.self).goToRecognitionView()
        }

        then("cars list view should not be visible") {
            XCTAssertFalse(self.app.on(screen: CarsList.self).isDisplayed)
        }

        then("recognition should be visible") {
            XCTAssertTrue(self.app.on(screen: Recognition.self).isDisplayed)
        }
    }
}

// MARK: - Snapshot tests
extension CarsListTestCase {

    private var isOnRecordMode: Bool {
        return false
    }

    private func swipeLeft() {
        app.on(screen: CarsList.self).app.swipeLeft()
    }

    @discardableResult
    private func verifyView(_ identifier: String) -> Screen {
        return app.on(screen: CarsList.self)
            .wait(for: 2).verifyView(testCase: self,
                                     record: isOnRecordMode,
                                     agnosticOptions: [.screenSize],
                                     identifier: identifier)
    }

    func testHondaCivicScreenLook() {
        verifyView("initial_view")
    }

    func testFordFiestaScreenLook() {
        swipeLeft()
        verifyView("after_1_swipe_left")
    }

    func testNissanQashqaiScreenLook() {
        for _ in 1...2 {
            swipeLeft()
        }
        verifyView("after_2_swipe_left")
    }

    func testVolkswagenPassatScreenLook() {
        for _ in 1...3 {
            swipeLeft()
        }
        verifyView("after_3_swipe_left")
    }
}

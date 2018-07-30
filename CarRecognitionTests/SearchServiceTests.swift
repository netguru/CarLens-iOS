//
//  SearchServiceTests.swift
//  CarRecognitionTests
//


@testable import CarRecognition
import XCTest

class SearchServiceTests: XCTestCase {
    
    var sut: SearchService!
    
    func testSearch() {
        // given
        let urlOpenerService = URLOpenerService(with: UIApplicationMock())
        sut = SearchService(with: urlOpenerService)
        let service = SearchService.Service.google
        guard let car = Car.make() else {
            XCTFail("Local car shouldn't be nil")
            return
        }
        let waitForURLToOpen = expectation(description: "Open a search service url.")
        // when
        sut.search(service, for: car, completion: { opened in
            waitForURLToOpen.fulfill()
            //then
            XCTAssert(opened == true, "Should have opened a search service url.")
        })
        waitForExpectations(timeout: 0.1, handler: nil)
    }
}

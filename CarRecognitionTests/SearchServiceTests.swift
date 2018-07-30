//
//  SearchServiceTests.swift
//  CarRecognitionTests
//


@testable import CarRecognition
import XCTest

final class SearchServiceTests: XCTestCase {
    
    var sut: SearchService!
    
    func testSearchForGoogle() {
        // given
        let applicationMock = UIApplicationMock()
        let urlOpenerService = URLOpenerService(with: applicationMock)
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
            XCTAssert(applicationMock.urlString == "https://www.google.com/search?q=\(car.make)%20\(car.model)", "Should have generated a google search service url.")
            XCTAssert(opened == true, "Should have opened a search service url.")
        })
        waitForExpectations(timeout: 0.1, handler: nil)
    }
}

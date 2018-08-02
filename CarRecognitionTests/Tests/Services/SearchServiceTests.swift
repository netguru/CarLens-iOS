//
//  SearchServiceTests.swift
//  CarRecognitionTests
//


@testable import CarRecognition
import XCTest

final class SearchServiceTests: XCTestCase {
    
    var sut: SearchService!
    
    var applicationMock: UIApplicationMock!
    
    var urlOpenerService: URLOpenerService!
    
    override func setUp() {
        super.setUp()
        applicationMock = UIApplicationMock()
        urlOpenerService = URLOpenerService(with: applicationMock)
        sut = SearchService(with: urlOpenerService)
    }
    
    override func tearDown() {
        super.tearDown()
        applicationMock = nil
        urlOpenerService = nil
        sut = nil
    }
    
    func testSearchForGoogle() {
        // given
        let service = SearchService.Service.google
        guard let car = Car.make() else {
            XCTFail("Local car shouldn't be nil")
            return
        }
        let waitForURLToOpen = expectation(description: "Open a search service url.")
        // when
        sut.search(service, for: car, completion: { opened in
            waitForURLToOpen.fulfill()
            // then
            XCTAssert(self.applicationMock.urlString == "https://www.google.com/search?q=\(car.make)%20\(car.model)", "Should have generated a google search service url.")
            XCTAssert(opened == true, "Should have opened a search service url.")
        })
        waitForExpectations(timeout: 0.1, handler: nil)
    }
}

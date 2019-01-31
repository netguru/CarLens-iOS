//
//  InputNormalizationServiceTests.swift
//  CarLensTests
//

@testable import CarLens
import XCTest

final class InputNormalizationServiceTests: XCTestCase {

    var sut: InputNormalizationService!

    var carsDataService: CarsDataService!

    override func setUp() {
        super.setUp()
        carsDataService = CarsDataService()
        sut = InputNormalizationService(numberOfValues: 3, carsDataService: carsDataService)
    }

    func testWithOneValue() {
        guard let recognitionResult = RecognitionResult(label: RecognitionResultTests.Labels.notCar,
                                                        confidence: 0.75,
                                                        carsDataService: carsDataService) else {
            XCTFail("Recognition result can't be nil")
            return
        }
        let result = sut.normalizeConfidence(from: [recognitionResult])
        XCTAssertNil(result,
                     "Result should be nil if the recognition results count is" +
                     "less then number of values for a normalization")
    }

    func testAfterAddingValues() {
        testWithOneValue()
        guard let firstResult = RecognitionResult(label: RecognitionResultTests.Labels.otherCar,
                                                  confidence: 0.2,
                                                  carsDataService: carsDataService),
            let secondResult = RecognitionResult(label: RecognitionResultTests.Labels.otherCar,
                                                 confidence: 0.6,
                                                 carsDataService: carsDataService) else {
            XCTFail("Recognition results can't be nil")
            return
        }
        let result = sut.normalizeConfidence(from: [firstResult, secondResult])
        XCTAssertEqual(result?.confidence,
                       0.75,
                       "Result confidence should be the highest average from all of the previous results")
        XCTAssertEqual(result?.label,
                       RecognitionResultTests.Labels.notCar,
                       "Result confidence should be the highest average from all of the previous results")
    }

    func testWithThreeValuesOutOfThree() {
        guard let firstResult = RecognitionResult(label: RecognitionResultTests.Labels.notCar,
                                                  confidence: 0.7,
                                                  carsDataService: carsDataService),
            let secondResult = RecognitionResult(label: RecognitionResultTests.Labels.notCar,
                                                 confidence: 0.5,
                                                 carsDataService: carsDataService),
            let thirdResult = RecognitionResult(label: RecognitionResultTests.Labels.otherCar,
                                                confidence: 0.2,
                                                carsDataService: carsDataService) else {
            XCTFail("Recognition results can't be nil")
            return
        }
        let result = sut.normalizeConfidence(from: [firstResult, secondResult, thirdResult])
        XCTAssertEqual(result?.confidence, 0.6, "Result confidence should be the highest average")
        XCTAssertEqual(result?.label,
                       RecognitionResultTests.Labels.notCar,
                       "Result confidence should be the highest average")
    }

}

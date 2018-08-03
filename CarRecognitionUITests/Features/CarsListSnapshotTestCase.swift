//
//  CarsListSnapshotTestCase.swift
//  CarRecognitionUITests
//


import XCTest
//import FBSnap

@testable import CarRecognition

import FBSnapshotTestCase


class CarsListSnapshotTestCase: FBSnapshotTestCase {
    
    override func setUp() {
        super.setUp()
        recordMode = true
    }

    func testCarsListSnapshotView() {
        let carsListViewController = CarsListViewController(carsDataService: CarsDataService())
        FBSnapshotVerifyView(carsListViewController.view)
    }
    
}

//
//  RequestStatusTests.swift
//  fetch-take-home-projectTests
//
//  Created by Blake Mitchell on 10/4/24.
//

import XCTest

@testable import fetch_take_home_project

final class RequestStatusTests: XCTestCase {
    
    func testShowOverlay() {
        let successStatus = RequestStatus.success
        let successNoResultsStatus = RequestStatus.successNoResults
        let errorStatus = RequestStatus.error
        let loadingStatus = RequestStatus.loading

        XCTAssertEqual(successStatus.showOverlay(), false)
        XCTAssertEqual(successNoResultsStatus.showOverlay(), true)
        XCTAssertEqual(errorStatus.showOverlay(), true)
        XCTAssertEqual(loadingStatus.showOverlay(), true)
    }
}

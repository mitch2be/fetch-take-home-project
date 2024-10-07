//
//  URLRequestTests.swift
//  fetch-take-home-projectTests
//
//  Created by Blake Mitchell on 10/4/24.
//

import XCTest
import Mocker

@testable import DataTypes
@testable import fetch_take_home_project

final class URLRequestTests: XCTestCase {
    
    private var session: URLSession!
    
    override func setUp() async throws {
        session = MockURLSessionConfig().session
    }
    
    func testRecipeListFetchingURLSession() throws {
        let endpoint = URL(string: "https://test.api/recipes")!
        
        var mock = Mock(url: endpoint, contentType: .json, statusCode: 200, data: [.get: try! Data(contentsOf: MockedData.recipes_JSON)])
        mock.register()
        
        let requestExpectation = expectationForRequestingMock(&mock)
        let completionExpectation = expectationForCompletingMock(&mock)
        
        let client = MockHTTPRequest(session: session)
        let loader = RecipeFeedLoader(client: client, request: mock.request)
        let mockedData = try Data(contentsOf: MockedData.recipes_JSON)
        let mockedjson = try JSONSerialization.jsonObject(with: mockedData, options: [])
        
        let expectedRecipeList = loader.decodeResults(json: mockedjson)
                
        loader.load { result in
            switch result {
            case .success(let list):
                XCTAssertTrue(list == expectedRecipeList)
            case .failure(let error):
                XCTAssertThrowsError(error.localizedDescription)
            }
            
            requestExpectation.fulfill()
            completionExpectation.fulfill()
        }
        
        wait(for: [requestExpectation, completionExpectation], timeout: 2.0)
    }
    
    func testEmptyRecipeListFetchingURLSession() throws {
        let endpoint = URL(string: "https://test.api/recipes")!
        
        var mock = Mock(url: endpoint, contentType: .json, statusCode: 200, data: [.get: try! Data(contentsOf: MockedData.recipes_empty_JSON)])
        mock.register()
        
        let requestExpectation = expectationForRequestingMock(&mock)
        let completionExpectation = expectationForCompletingMock(&mock)
        
        let client = MockHTTPRequest(session: session)
        let loader = RecipeFeedLoader(client: client, request: mock.request)
        let mockedData = try Data(contentsOf: MockedData.recipes_empty_JSON)
        let mockedjson = try JSONSerialization.jsonObject(with: mockedData, options: [])
        
        let expectedRecipeList = loader.decodeResults(json: mockedjson)
        
        loader.load { result in
            switch result {
            case .success(let list):
                XCTAssertTrue(list == expectedRecipeList)
            case .failure(let error):
                XCTAssertThrowsError(error.localizedDescription)
            }
            
            requestExpectation.fulfill()
            completionExpectation.fulfill()
        }
        
        wait(for: [requestExpectation, completionExpectation], timeout: 2.0)
    }
}

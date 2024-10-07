//
//  MockHTTPRequest.swift
//  fetch-take-home-projectTests
//
//  Created by Blake Mitchell on 10/4/24.
//

import Foundation

@testable import HTTPRequest

class MockedData {
    public static let recipes_JSON: URL = Bundle(for: MockedData.self).url(forResource: "recipes", withExtension: "json")!
    public static let recipes_malformed_JSON: URL = Bundle(for: MockedData.self).url(forResource: "recipes-malformed", withExtension: "json")!
    public static let recipes_empty_JSON: URL = Bundle(for: MockedData.self).url(forResource: "recipes-empty", withExtension: "json")!
}

struct MockHTTPRequest: HTTPClient {
    
    private let session: URLSession
    
    public init(session: URLSession) {
        self.session = session
    }
    
    public func request(_ request: URLRequest, completion: @escaping (RequestResult) -> Void) {
        let task = session.dataTask(with: request) { data, response, error in
            let statusCode = statusCode(response: response)
            
            guard let data = data else {
                completion(.failure(RequestError.noData, statusCode))
                return
            }
                        
            guard let json = try? JSONSerialization.jsonObject(with: data, options: []) else {
                completion(.failure(RequestError.jsonSerializationFailed, statusCode))
                return
                
            }
            
            completion(.success(json, statusCode))
            
            return
        }
        
        task.resume()
    }
}

extension MockHTTPRequest {
    
    private func statusCode(response: URLResponse?) -> Int? {
        if let urlResponse = response as? HTTPURLResponse {
            return urlResponse.statusCode
        }
        
        return nil
    }
}

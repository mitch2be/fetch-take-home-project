//
//  HTTPRequestClient.swift
//  HTTPRequest
//
//  Created by Blake Mitchell on 10/4/24.
//

import Foundation

public protocol HTTPClient {
    
    typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>
    
    func request(_ request: URLRequest, completion: @escaping (RequestResult) -> Void)
}

public struct HTTPRequestClient: HTTPClient {
        
    private let session: URLSession

    public init(session: URLSession = .shared) {
        self.session = session
    }
            
    public func request(_ request: URLRequest, completion: @escaping (RequestResult) -> Void) {
        let task = session.dataTask(with: request) { data, response, error in
            completion(validateResponse(response: response, data: data, error: error))
            return
        }
        
        task.resume()
    }
}

extension HTTPRequestClient {
    
    private func validateResponse(response: URLResponse?, data: Data?, error: Error?) -> RequestResult {
        let statusCode = statusCode(response: response)
        
        if let error = error {
            return .failure(error, statusCode)
        }
        
        guard let data = data else {
            return .failure(RequestError.noData, statusCode)
        }

        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            
            return .success(json, statusCode)
        } catch {
            return .failure(RequestError.jsonSerializationFailed, statusCode)
        }
    }
    
    private func statusCode(response: URLResponse?) -> Int? {
        if let urlResponse = response as? HTTPURLResponse {
            return urlResponse.statusCode
        }
        
        return nil
    }
}

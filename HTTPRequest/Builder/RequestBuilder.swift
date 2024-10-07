//
//  RequestBuilder.swift
//  HTTPRequest
//
//  Created by Blake Mitchell on 10/4/24.
//

import Foundation

public struct RequestBuilder {
    
    var url: URL
    var type: RequestMethodType

    public func build() -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = type.rawValue
                
        return request
    }
}

extension RequestBuilder {
    
    public init(urlString: String, _ type: RequestMethodType = .GET) {
        guard let url = URL(string: urlString) else {
            preconditionFailure("Invalid URL string: \(urlString)")
        }
        
        self.url = url
        self.type = type
    }
}

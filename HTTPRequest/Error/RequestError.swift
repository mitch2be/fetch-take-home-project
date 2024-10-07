//
//  RequestError.swift
//  HTTPRequest
//
//  Created by Blake Mitchell on 10/4/24.
//

import Foundation

public enum RequestError: Swift.Error {
    case noData
    case jsonSerializationFailed
}
